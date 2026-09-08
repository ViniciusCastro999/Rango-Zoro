// Lê restaurantes/<slug>/{info.yaml,cardapio.yaml} e gera supabase/seed.sql
// com os INSERTs pra popular o banco uma vez. Uso: node scripts/exportar-para-sql.mjs
// O SQL roda no SQL Editor do Supabase (web), sem meta-comandos de psql.
import fs from 'node:fs';
import path from 'node:path';
import yaml from 'js-yaml';

const RAIZ = path.resolve('restaurantes');
const SAIDA = path.resolve('supabase/seed.sql');

const q = (v) => (v == null ? 'null' : `'${String(v).replace(/'/g, "''")}'`);
const num = (v) =>
  v == null || v === '' || Number.isNaN(Number(v)) ? 'null' : String(Number(v));
const bool = (v) => (v ? 'true' : 'false');
const arr = (v) =>
  Array.isArray(v) && v.length ? `array[${v.map((x) => q(x)).join(',')}]::text[]` : `'{}'::text[]`;
const jsonb = (v) => `'${JSON.stringify(v ?? {}).replace(/'/g, "''")}'::jsonb`;

const slugs = fs
  .readdirSync(RAIZ)
  .filter((d) => !d.startsWith('.') && fs.statSync(path.join(RAIZ, d)).isDirectory())
  .sort();

let sql = `-- Gerado por scripts/exportar-para-sql.mjs em ${new Date().toISOString()}
-- Rode no SQL Editor do Supabase DEPOIS do schema.sql.
-- Pode rodar de novo quando quiser: limpa tudo e recarrega a partir dos YAML.
truncate itens, categorias, restaurantes restart identity cascade;

`;

for (const slug of slugs) {
  const info = yaml.load(fs.readFileSync(path.join(RAIZ, slug, 'info.yaml'), 'utf8')) ?? {};
  const cardapioPath = path.join(RAIZ, slug, 'cardapio.yaml');
  const cardapio = fs.existsSync(cardapioPath)
    ? (yaml.load(fs.readFileSync(cardapioPath, 'utf8')) ?? {})
    : {};

  const publicado = info.publicado === undefined ? true : !!info.publicado;
  sql += `-- ${info.nome ?? slug}\n`;
  sql +=
    `insert into restaurantes (slug, nome, categoria, cozinha, bairro, endereco, whatsapp, site_pedido, instagram, emoji, taxa_entrega, taxa_entrega_valor, pedido_minimo, pedido_minimo_valor, pagamentos, horarios, pausado, pausa_motivo, destaque, publicado, cardapio_atualizado_em, observacoes, posicao) values (\n` +
    `  ${q(slug)}, ${q(info.nome)}, ${q(info.categoria ?? 'Outros')}, ${arr(info.cozinha)}, ${q(info.bairro)}, ${q(info.endereco)}, ${q(info.whatsapp)}, ${q(info.site_pedido)}, ${q(info.instagram)}, ${q(info.emoji)}, ${q(info.taxa_entrega)}, ${num(info.taxa_entrega_valor)}, ${q(info.pedido_minimo)}, ${num(info.pedido_minimo_valor)}, ${arr(info.pagamentos)}, ${jsonb(info.horarios)}, ${bool(info.pausado)}, ${q(info.pausa_motivo)}, ${bool(info.destaque)}, ${bool(publicado)}, ${q(cardapio.atualizado_em)}, ${q(cardapio.observacoes)}, 100\n` +
    `);\n`;

  const cats = Array.isArray(cardapio.categorias) ? cardapio.categorias : [];
  cats.forEach((cat, ci) => {
    sql += `insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values (${q(slug)}, ${q(cat.nome)}, ${bool(cat.meio_a_meio)}, ${(ci + 1) * 10});\n`;
    const itens = Array.isArray(cat.itens) ? cat.itens : [];
    if (itens.length) {
      sql += `insert into itens (categoria_id, nome, preco, descricao, posicao) values\n`;
      sql += itens
        .map(
          (it, ii) =>
            `  ((select id from categorias where restaurante_slug=${q(slug)} and nome=${q(cat.nome)}), ${q(it.nome)}, ${num(it.preco)}, ${q(it.descricao)}, ${(ii + 1) * 10})`,
        )
        .join(',\n');
      sql += `;\n`;
    }
  });
  sql += `\n`;
}

fs.writeFileSync(SAIDA, sql);
console.log('gerado', SAIDA, `(${slugs.length} restaurantes)`);
