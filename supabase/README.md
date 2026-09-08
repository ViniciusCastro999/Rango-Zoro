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

- **Site** lê a view `restaurantes_completos` (só `publicado`, cardápio já montado em
  JSON). Leitura é pública; escrever exige estar logado (RLS).
- **Editar preço, item, horário, pausar, publicar:** em `https://.../Rango-Zoro/admin`
  (login com o usuário que você criou no Supabase). Também dá pra editar direto no Table
  Editor do Supabase.
- **Quando vai pro ar:** o site é re-buildado sozinho a cada ~5 min (o GitHub costuma
  atrasar o agendado, na prática dá 10-15 min). Pra ir na hora: Actions > Deploy no GitHub
  Pages > **Run workflow**.
- **`publicado`:** restaurante com `publicado = false` não aparece no site nem gera página.
  Use pra deixar um lugar em rascunho enquanto acerta os dados.

## Regenerar o seed a partir dos YAML

```bash
node scripts/exportar-para-sql.mjs   # reescreve supabase/seed.sql
```

Enquanto os dois modos convivem, os YAML em `restaurantes/` são o fallback de quando não
há `.env`. Depois que o Supabase estiver redondo dá pra apagar os YAML.
