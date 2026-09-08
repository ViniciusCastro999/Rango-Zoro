import fs from 'node:fs';
import path from 'node:path';
import yaml from 'js-yaml';

const RAIZ = path.resolve(process.cwd(), 'restaurantes');

export type Faixa = [string, string];
export type Horarios = Partial<Record<'seg' | 'ter' | 'qua' | 'qui' | 'sex' | 'sab' | 'dom', Faixa | Faixa[] | null>>;

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

function lerYaml<T>(p: string): T | null {
  if (!fs.existsSync(p)) return null;
  return (yaml.load(fs.readFileSync(p, 'utf8')) as T) ?? null;
}

export function getRestaurantes(): Restaurante[] {
  if (!fs.existsSync(RAIZ)) return [];

  const slugs = fs
    .readdirSync(RAIZ)
    .filter((d) => !d.startsWith('.') && fs.statSync(path.join(RAIZ, d)).isDirectory());

  const lista = slugs
    .map((slug) => {
      const info = lerYaml<Info>(path.join(RAIZ, slug, 'info.yaml'));
      if (!info?.nome) return null;
      return {
        ...info,
        slug,
        cardapio: lerYaml<Cardapio>(path.join(RAIZ, slug, 'cardapio.yaml')),
      } satisfies Restaurante;
    })
    .filter((r): r is Restaurante => r !== null);

  return lista.sort(
    (a, b) =>
      Number(Boolean(b.destaque)) - Number(Boolean(a.destaque)) ||
      a.nome.localeCompare(b.nome, 'pt-BR'),
  );
}

export function getRestaurante(slug: string): Restaurante | undefined {
  return getRestaurantes().find((r) => r.slug === slug);
}

/** Categorias distintas, na ordem em que aparecem, pros filtros da home. */
export function getCategorias(lista: Restaurante[]): string[] {
  return [...new Set(lista.map((r) => r.categoria).filter(Boolean))].sort((a, b) =>
    a.localeCompare(b, 'pt-BR'),
  );
}
