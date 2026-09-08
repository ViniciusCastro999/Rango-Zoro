import fs from 'node:fs';
import path from 'node:path';
import yaml from 'js-yaml';
import { SUPABASE_URL, SUPABASE_ANON, temSupabase } from './supabase';

const RAIZ = path.resolve(process.cwd(), 'restaurantes');

export type Faixa = [string, string];
export type Horarios = Partial<
  Record<'seg' | 'ter' | 'qua' | 'qui' | 'sex' | 'sab' | 'dom', Faixa | Faixa[] | null>
>;

export interface Info {
  nome: string;
  categoria: string;
  cozinha?: string[];
  bairro?: string;
  endereco?: string;
  whatsapp?: string;
  site_pedido?: string; // se o lugar recebe pedido por um site de fora, não pelo WhatsApp
  instagram?: string;
  emoji?: string;
  taxa_entrega?: string;
  taxa_entrega_valor?: number;
  pedido_minimo?: string;
  pedido_minimo_valor?: number;
  pagamentos?: string[];
  horarios: Horarios;
  pausado?: boolean;
  pausa_motivo?: string;
  pausa_ate?: string;
  destaque?: boolean;
}

export interface ItemCardapio {
  nome: string;
  preco?: number;
  descricao?: string;
}

export interface CategoriaCardapio {
  nome: string;
  itens: ItemCardapio[];
  meio_a_meio?: boolean; // categoria de pizza: aceita montar meia a meia
}

export interface Cardapio {
  atualizado_em?: string;
  categorias: CategoriaCardapio[];
  observacoes?: string;
}

export interface Restaurante extends Info {
  slug: string;
  cardapio: Cardapio | null;
}

// ---------- fonte: Supabase (produção e dev com .env) ----------

interface LinhaSupabase extends Record<string, unknown> {
  slug: string;
  nome: string;
  categoria: string;
  cozinha: string[] | null;
  pagamentos: string[] | null;
  horarios: Horarios | null;
  taxa_entrega_valor: number | string | null;
  pedido_minimo_valor: number | string | null;
  cardapio_atualizado_em: string | null;
  observacoes: string | null;
  categorias: Array<{ nome: string; meio_a_meio?: boolean; itens?: ItemCardapio[] }> | null;
}

function daLinha(l: LinhaSupabase): Restaurante {
  const cats = (l.categorias ?? []).map((c) => ({
    nome: c.nome,
    meio_a_meio: c.meio_a_meio || undefined,
    itens: (c.itens ?? []).map((i) => ({
      nome: i.nome,
      preco: i.preco ?? undefined,
      descricao: i.descricao || undefined,
    })),
  }));
  const numero = (v: unknown) => (v == null || v === '' ? undefined : Number(v));
  return {
    slug: l.slug,
    nome: l.nome,
    categoria: l.categoria,
    cozinha: l.cozinha ?? [],
    bairro: (l.bairro as string) || undefined,
    endereco: (l.endereco as string) || undefined,
    whatsapp: (l.whatsapp as string) || undefined,
    site_pedido: (l.site_pedido as string) || undefined,
    instagram: (l.instagram as string) || undefined,
    emoji: (l.emoji as string) || undefined,
    taxa_entrega: (l.taxa_entrega as string) || undefined,
    taxa_entrega_valor: numero(l.taxa_entrega_valor),
    pedido_minimo: (l.pedido_minimo as string) || undefined,
    pedido_minimo_valor: numero(l.pedido_minimo_valor),
    pagamentos: l.pagamentos ?? [],
    horarios: l.horarios ?? {},
    pausado: Boolean(l.pausado),
    pausa_motivo: (l.pausa_motivo as string) || undefined,
    destaque: Boolean(l.destaque),
    cardapio: cats.length
      ? {
          atualizado_em: l.cardapio_atualizado_em || undefined,
          categorias: cats,
          observacoes: l.observacoes || undefined,
        }
      : null,
  };
}

async function doSupabase(): Promise<Restaurante[]> {
  const r = await fetch(
    `${SUPABASE_URL}/rest/v1/restaurantes_completos?select=*&order=destaque.desc,posicao.asc,nome.asc`,
    {
      headers: {
        apikey: SUPABASE_ANON!,
        Authorization: `Bearer ${SUPABASE_ANON}`,
      },
    },
  );
  if (!r.ok) throw new Error(`Supabase ${r.status}: ${await r.text()}`);
  const linhas = (await r.json()) as LinhaSupabase[];
  return linhas.map(daLinha);
}

// ---------- fonte: YAML (fallback local sem .env) ----------

function lerYaml<T>(p: string): T | null {
  if (!fs.existsSync(p)) return null;
  return (yaml.load(fs.readFileSync(p, 'utf8')) as T) ?? null;
}

function doYaml(): Restaurante[] {
  if (!fs.existsSync(RAIZ)) return [];
  const slugs = fs
    .readdirSync(RAIZ)
    .filter((d) => !d.startsWith('.') && fs.statSync(path.join(RAIZ, d)).isDirectory());

  return slugs
    .map((slug) => {
      const info = lerYaml<Info>(path.join(RAIZ, slug, 'info.yaml'));
      if (!info?.nome) return null;
      return { ...info, slug, cardapio: lerYaml<Cardapio>(path.join(RAIZ, slug, 'cardapio.yaml')) };
    })
    .filter((r): r is Restaurante => r !== null)
    .sort(
      (a, b) =>
        Number(Boolean(b.destaque)) - Number(Boolean(a.destaque)) ||
        a.nome.localeCompare(b.nome, 'pt-BR'),
    );
}

// ---------- API ----------

let _cache: Promise<Restaurante[]> | null = null;

export function getRestaurantes(): Promise<Restaurante[]> {
  _cache ??= temSupabase ? doSupabase() : Promise.resolve(doYaml());
  return _cache;
}

export async function getRestaurante(slug: string): Promise<Restaurante | undefined> {
  return (await getRestaurantes()).find((r) => r.slug === slug);
}

/** Categorias distintas pros filtros da home. */
export function getCategorias(lista: Restaurante[]): string[] {
  return [...new Set(lista.map((r) => r.categoria).filter(Boolean))].sort((a, b) =>
    a.localeCompare(b, 'pt-BR'),
  );
}
