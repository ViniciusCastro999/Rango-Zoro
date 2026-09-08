-- RangoZoro, esquema do banco (Supabase / Postgres).
-- Rode isto uma vez no SQL Editor do Supabase (aba SQL Editor > New query > Run).

-- ---------- tabelas ----------

create table if not exists restaurantes (
  slug                  text primary key,
  nome                  text not null,
  categoria             text not null default 'Outros',
  cozinha               text[] not null default '{}',
  bairro                text,
  endereco              text,
  whatsapp              text,
  site_pedido           text,
  instagram             text,
  emoji                 text,
  taxa_entrega          text,
  taxa_entrega_valor    numeric,
  pedido_minimo         text,
  pedido_minimo_valor   numeric,
  pagamentos            text[] not null default '{}',
  horarios              jsonb not null default '{}',
  pausado               boolean not null default false,
  pausa_motivo          text,
  destaque              boolean not null default false,
  cardapio_atualizado_em date,
  observacoes           text,
  publicado             boolean not null default true,
  posicao               int not null default 100,
  atualizado_em         timestamptz not null default now()
);

create table if not exists categorias (
  id                bigint generated always as identity primary key,
  restaurante_slug  text not null references restaurantes(slug) on delete cascade,
  nome              text not null,
  meio_a_meio       boolean not null default false,
  posicao           int not null default 100,
  unique (restaurante_slug, nome)
);
create index if not exists categorias_restaurante_idx on categorias(restaurante_slug);

create table if not exists itens (
  id            bigint generated always as identity primary key,
  categoria_id  bigint not null references categorias(id) on delete cascade,
  nome          text not null,
  preco         numeric,
  descricao     text,
  posicao       int not null default 100
);
create index if not exists itens_categoria_idx on itens(categoria_id);

-- carimba atualizado_em quando o restaurante muda
create or replace function toca_atualizado_em() returns trigger as $$
begin
  new.atualizado_em = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists restaurantes_atualizado_em on restaurantes;
create trigger restaurantes_atualizado_em before update on restaurantes
  for each row execute function toca_atualizado_em();

-- ---------- segurança (RLS) ----------
-- Leitura liberada pra todo mundo (o site é público).
-- Escrita só pra quem está logado (você, no /admin).

alter table restaurantes enable row level security;
alter table categorias   enable row level security;
alter table itens         enable row level security;

drop policy if exists "leitura publica" on restaurantes;
create policy "leitura publica" on restaurantes for select using (true);
drop policy if exists "escrita logada" on restaurantes;
create policy "escrita logada" on restaurantes for all
  using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

drop policy if exists "leitura publica" on categorias;
create policy "leitura publica" on categorias for select using (true);
drop policy if exists "escrita logada" on categorias;
create policy "escrita logada" on categorias for all
  using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

drop policy if exists "leitura publica" on itens;
create policy "leitura publica" on itens for select using (true);
drop policy if exists "escrita logada" on itens;
create policy "escrita logada" on itens for all
  using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

-- ---------- view pronta pro site ----------
-- devolve cada restaurante com o cardápio já montado em JSON,
-- na ordem certa. O site lê só disto.

create or replace view restaurantes_completos as
select
  r.*,
  coalesce(
    (
      select jsonb_agg(cat order by cat.posicao, cat.nome)
      from (
        select
          c.nome,
          c.meio_a_meio,
          c.posicao,
          coalesce(
            (
              select jsonb_agg(
                jsonb_strip_nulls(jsonb_build_object(
                  'nome', i.nome,
                  'preco', i.preco,
                  'descricao', i.descricao
                ))
                order by i.posicao, i.nome
              )
              from itens i where i.categoria_id = c.id
            ),
            '[]'::jsonb
          ) as itens
        from categorias c
        where c.restaurante_slug = r.slug
      ) cat
    ),
    '[]'::jsonb
  ) as categorias
from restaurantes r
where r.publicado;

grant select on restaurantes_completos to anon, authenticated;
