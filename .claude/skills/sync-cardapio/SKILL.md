---
name: sync-cardapio
description: Atualiza o cardápio de um restaurante do RangoZoro a partir dos arquivos brutos (fotos, prints de WhatsApp, PDFs, links de cardápio) na pasta restaurantes/<slug>/fontes/. Extrai itens e preços, mostra um diff em português e, depois da aprovação, gera um SQL pra colar no Supabase. Use quando o usuário rodar /sync-cardapio, pedir para "sincronizar", "atualizar cardápio", "processar as fotos do cardápio" ou similar.
---

# sync-cardapio

Transforma material bruto de cardápio (fotos, prints, PDF) em atualização do banco, com
revisão humana obrigatória antes de qualquer gravação.

Os dados moram no **Supabase** (tabelas `restaurantes`, `categorias`, `itens`). O
`restaurantes/<slug>/cardapio.yaml` é mantido como rascunho revisável e backup no git; a
partir dele sai o SQL que o usuário cola no Supabase.

## Entrada

`/sync-cardapio <slug>`: um restaurante (ex.: `red-lanches`).
`/sync-cardapio` sem argumento: varra `restaurantes/*/fontes/` e liste os que têm arquivos
novos (mais recentes que o `cardapio.yaml`); pergunte qual processar.

Fontes: fotos de cardápio impresso, prints de WhatsApp, PDF, foto de story/post. Link de
cardápio (Anota AI, Goomer, Cardápio Web, iFood, Instagram) → use WebFetch.

## Passos

1. **Contexto.** Leia `restaurantes/<slug>/info.yaml` e liste `restaurantes/<slug>/fontes/`.
   Pegue o cardápio **atual do banco** como referência do diff:

   ```bash
   curl -s "$PUBLIC_SUPABASE_URL/rest/v1/restaurantes_completos?slug=eq.<slug>&select=categorias" \
     -H "apikey: $PUBLIC_SUPABASE_ANON_KEY"
   ```

   (as variáveis estão no `.env`.) Se não vier nada, o restaurante ainda não está publicado
   ou não existe: confira com o usuário.

2. **Leia as fontes.** Read em cada imagem/PDF; WebFetch em links.

3. **Extraia o cardápio** no schema abaixo. Regras:
   - Preço é número em reais com ponto (`45.00`). Sem `R$`, sem string.
   - Item que já existe e só mudou o preço: **mesmo nome, mesma posição**. Não duplique.
   - Preço ilegível/ausente na fonte: mantenha o valor atual e marque ⚠ no diff. Nunca invente.
   - Não crie item que não está nas fontes.
   - Categoria de pizza (grande, broto, doce): `meio_a_meio: true`. O site cobra a metade mais cara.
   - Variações que o site não tem (tamanhos P/M/G, tipos de carne): vira **item separado**
     com o tamanho no nome (`Batata frita (média)`), ou **categorias separadas**
     (`Hambúrgueres de picanha`). Preço sempre real.
   - Observações gerais (borda, meia porção, mínimo) vão em `observacoes`.
   - Taxa, mínimo, pagamento, horário: se aparecerem claros, ofereça atualizar o
     `info.yaml` como pergunta separada no fim. Isso o usuário também edita no `/admin`.

4. **Mostre o diff em português**, sem gravar nada. Formato:

   ```
   RED Lanches, proposta de atualização

   Preços alterados
     X-Burguer            R$ 18,00 → R$ 19,00

   Itens novos
     + X-Costela          R$ 27,00   (em "Lanches tradicionais")

   Itens removidos (não achei nas fontes)
     - Combo kids

   Atenção
     ⚠ X-Tudo: preço ilegível na foto, mantido R$ 35,00

   info.yaml (à parte)
     Horário sábado passa a 12:00 → 00:00 (confirmar)
   ```

5. **Espere "ok" explícito.** Ajuste o diff se pedirem. **Nunca grave sem aprovação.**

6. **Ao aprovar:**
   - Grave `restaurantes/<slug>/cardapio.yaml` (schema abaixo, `atualizado_em` = hoje).
     É o backup versionado.
   - Gere o SQL: `node scripts/exportar-para-sql.mjs --slug <slug>` →
     `supabase/sync-<slug>.sql`.
   - Diga pro usuário: **abre o SQL Editor do Supabase, cola o conteúdo de
     `supabase/sync-<slug>.sql`, Run.** É uma transação (tudo ou nada) que troca as
     categorias e itens desse restaurante.
   - Se aprovaram mudança de `info.yaml`, grave o YAML e lembre que os campos de contato
     também dão pra editar no `/admin` (mais rápido).

7. **Feche.** O site re-builda sozinho a cada ~5 min (com atraso do GitHub, ~10-15 min).
   Pra ir na hora: Actions > Deploy no GitHub Pages > Run workflow. Sugira o commit do
   `cardapio.yaml` (é backup, não obrigatório pro site).

## Schema do cardapio.yaml

```yaml
atualizado_em: "2026-09-08"
categorias:
  - nome: Pizzas grandes
    meio_a_meio: true
    itens:
      - nome: Calabresa
        preco: 52.00
        descricao: Mussarela, calabresa e cebola   # opcional
observacoes: >-
  Borda recheada + R$ 6. Meio a meio: valor da mais cara.
```

## Observações

- Não mexa em `restaurantes/<slug>/fontes/`. Os brutos ficam lá, fora do git.
- `supabase/sync-*.sql` é descartável (roda uma vez), está no `.gitignore`.
- Se não houver `info.yaml` pro slug, o restaurante não foi cadastrado: o cadastro inicial
  é no `/admin` (botão "novo restaurante") ou à mão. Avise em vez de criar do zero.
- Editar preço de um ou dois itens não precisa disto: é mais rápido no `/admin`.
