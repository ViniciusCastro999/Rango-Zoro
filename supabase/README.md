# RangoZoro no Supabase

Os cardápios e dados dos restaurantes moram num banco Postgres no Supabase.
Editar lá reflete no site sem precisar de commit nem esperar build.

## Montar o banco (uma vez)

1. Cria conta em https://supabase.com e um projeto novo (região São Paulo).
2. No painel: **SQL Editor > New query**, cola o conteúdo de [`schema.sql`](schema.sql) e **Run**.
3. Mesma coisa com [`seed.sql`](seed.sql) (carrega os restaurantes que já existiam nos YAML).
4. **Settings > API**: copia `Project URL` e a chave `anon public`.
5. Bota essas duas no repositório:
   - Local: cria `.env` (veja `.env.example`) com `PUBLIC_SUPABASE_URL` e `PUBLIC_SUPABASE_ANON_KEY`.
   - GitHub: **Settings > Secrets and variables > Actions > New repository secret**, cria
     `PUBLIC_SUPABASE_URL` e `PUBLIC_SUPABASE_ANON_KEY` com os mesmos valores.
6. Cria seu usuário de admin: **Authentication > Users > Add user** (email + senha).
   É com ele que você entra em `/admin` pra editar.

## Como fica

- **Site** lê a view `restaurantes_completos` (cardápio já montado em JSON). Leitura é
  pública; escrever exige estar logado (RLS).
- **Editar preço, item, horário, pausar:** no `/admin` do site (ou direto no Table Editor
  do Supabase). Vale na hora, o site busca de novo ao abrir.
- **Restaurante novo:** aparece pro público no próximo build (o site pré-renderiza uma
  página por restaurante). Rode o deploy manual em Actions > Deploy > Run workflow, ou
  espere o próximo push.

## Regenerar o seed a partir dos YAML

```bash
node scripts/exportar-para-sql.mjs   # reescreve supabase/seed.sql
```

Enquanto os dois modos convivem, os YAML em `restaurantes/` são o fallback de quando não
há `.env`. Depois que o Supabase estiver redondo dá pra apagar os YAML.
