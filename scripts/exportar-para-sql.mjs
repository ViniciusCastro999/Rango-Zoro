// Converte os YAML de restaurantes/ em SQL pro Supabase.
//
//   node scripts/exportar-para-sql.mjs
//       -> supabase/seed.sql  (recria o banco inteiro a partir dos YAML)
//
//   node scripts/exportar-para-sql.mjs --slug pizzaria-do-ze
//       -> supabase/sync-pizzaria-do-ze.sql  (troca só o cardápio desse lugar,
//          numa transação; use depois do /sync-cardapio)
//
// O SQL roda no SQL Editor do Supabase (web), sem meta-comandos de psql.
import fs from 'node:fs';
import path from 'node:path';
import yaml from 'js-yaml';

const RAIZ = path.resolve('restaurantes');
const alvo = process.argv.includes('--slug')
  ? process.argv[process.argv.indexOf('--slug') + 1]
  : null;

const q = (v) => (v == null ? 'null' : `'${String(v).replace(/'/g, "''")}'`);
const num = (v) =>
  v == null || v === '' || Number.isNaN(Number(v)) ? 'null' : String(Number(v));
const bool = (v) => (v ? 'true' : 'false');
const arr = (v) =>
  Array.isArray(v) && v.length ? `array[${v.map((x) => q(x)).join(',')}]::text[]` : `'{}'::text[]`;
const jsonb = (v) => `'${JSON.stringify(v ?? {}).replace(/'/g, "''")}'::jsonb`;
const hoje = () => new Date().toISOString().slice(0, 10);

function ler(slug) {
  const info = yaml.load(fs.readFileSync(path.join(RAIZ, slug, 'info.yaml'), 'utf8')) ?? {};
  const cp = path.join(RAIZ, slug, 'cardapio.yaml');
  const cardapio = fs.existsSync(cp) ? (yaml.load(fs.readFileSync(cp, 'utf8')) ?? {}) : {};
  return { info, cardapio };
}

function inserirRestaurante(slug, info, cardapio) {
  const publicado = info.publicado === undefined ? true : !!info.publicado;
  return (
    `insert into restaurantes (slug, nome, categoria, cozinha, bairro, endereco, whatsapp, site_pedido, instagram, emoji, taxa_entrega, taxa_entrega_valor, pedido_minimo, pedido_minimo_valor, pagamentos, horarios, pausado, pausa_motivo, destaque, publicado, cardapio_atualizado_em, observacoes, posicao) values (\n` +
    `  ${q(slug)}, ${q(info.nome)}, ${q(info.categoria ?? 'Outros')}, ${arr(info.cozinha)}, ${q(info.bairro)}, ${q(info.endereco)}, ${q(info.whatsapp)}, ${q(info.site_pedido)}, ${q(info.instagram)}, ${q(info.emoji)}, ${q(info.taxa_entrega)}, ${num(info.taxa_entrega_valor)}, ${q(info.pedido_minimo)}, ${num(info.pedido_minimo_valor)}, ${arr(info.pagamentos)}, ${jsonb(info.horarios)}, ${bool(info.pausado)}, ${q(info.pausa_motivo)}, ${bool(info.destaque)}, ${bool(publicado)}, ${q(cardapio.atualizado_em)}, ${q(cardapio.observacoes)}, 100\n` +
    `);\n`
  );
}

function inserirCardapio(slug, cardapio) {
  let s = '';
  const cats = Array.isArray(cardapio.categorias) ? cardapio.categorias : [];
  cats.forEach((cat, ci) => {
    s += `insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values (${q(slug)}, ${q(cat.nome)}, ${bool(cat.meio_a_meio)}, ${(ci + 1) * 10});\n`;
    const itens = Array.isArray(cat.itens) ? cat.itens : [];
    if (itens.length) {
      s += `insert into itens (categoria_id, nome, preco, descricao, posicao) values\n`;
      s += itens
        .map(
          (it, ii) =>
            `  ((select id from categorias where restaurante_slug=${q(slug)} and nome=${q(cat.nome)}), ${q(it.nome)}, ${num(it.preco)}, ${q(it.descricao)}, ${(ii + 1) * 10})`,
        )
        .join(',\n');
      s += `;\n`;
    }
  });
  return s;
}

if (alvo) {
  // sync de um restaurante só: troca o cardápio numa transação
  const { info, cardapio } = ler(alvo);
  const saida = path.resolve(`supabase/sync-${alvo}.sql`);
  const sql =
    `-- Sync do cardápio de "${info.nome ?? alvo}" (${new Date().toISOString()}).\n` +
    `-- Cole no SQL Editor do Supabase. Roda tudo ou nada.\n` +
    `begin;\n` +
    `delete from categorias where restaurante_slug = ${q(alvo)};\n` +
    inserirCardapio(alvo, cardapio) +
    `update restaurantes set observacoes = ${q(cardapio.observacoes)}, cardapio_atualizado_em = ${q(cardapio.atualizado_em ?? hoje())} where slug = ${q(alvo)};\n` +
    `commit;\n`;
  fs.writeFileSync(saida, sql);
  console.log('gerado', saida);
} else {
  // banco inteiro
  const slugs = fs
    .readdirSync(RAIZ)
    .filter((d) => !d.startsWith('.') && fs.statSync(path.join(RAIZ, d)).isDirectory())
    .sort();
  let sql =
    `-- Gerado por scripts/exportar-para-sql.mjs em ${new Date().toISOString()}\n` +
    `-- Rode no SQL Editor do Supabase DEPOIS do schema.sql.\n` +
    `-- Recria tudo a partir dos YAML (apaga o que estiver no banco).\n` +
    `truncate itens, categorias, restaurantes restart identity cascade;\n\n`;
  for (const slug of slugs) {
    const { info, cardapio } = ler(slug);
    sql += `-- ${info.nome ?? slug}\n` + inserirRestaurante(slug, info, cardapio) + inserirCardapio(slug, cardapio) + `\n`;
  }
  fs.writeFileSync(path.resolve('supabase/seed.sql'), sql);
  console.log('gerado supabase/seed.sql', `(${slugs.length} restaurantes)`);
}
