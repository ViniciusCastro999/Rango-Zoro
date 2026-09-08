---
name: sync-cardapio
description: Atualiza o cardápio de um restaurante do RangoZoro a partir dos arquivos brutos (fotos, prints de WhatsApp, PDFs, links de cardápio) na pasta restaurantes/<slug>/fontes/. Extrai itens e preços, mostra um diff em português e só grava o YAML depois da aprovação. Use quando o usuário rodar /sync-cardapio, pedir para "sincronizar", "atualizar cardápio", "processar as fotos do cardápio" ou similar.
---

# sync-cardapio

Transforma material bruto de cardápio em `restaurantes/<slug>/cardapio.yaml`, com revisão humana obrigatória antes de gravar.

## Entrada

`/sync-cardapio <slug>`: um restaurante (ex.: `pizzaria-do-ze`).
`/sync-cardapio` sem argumento: varra `restaurantes/*/fontes/` e liste os que têm arquivos novos (mais recentes que o `atualizado_em` do `cardapio.yaml`); pergunte qual processar ou processe um a um.

As fontes podem ser: fotos de cardápio impresso, prints de conversa de WhatsApp, PDF, foto de story/post. Se o usuário passar um **link** de cardápio (Anota AI, Goomer, Cardápio Web, iFood, Instagram), use WebFetch para ler.

## Passos

1. **Carregue o contexto.** Leia `restaurantes/<slug>/info.yaml` e o `restaurantes/<slug>/cardapio.yaml` atual (se existir). Liste os arquivos em `restaurantes/<slug>/fontes/`.

2. **Leia as fontes.** Use Read para cada imagem/PDF (a ferramenta renderiza imagens). Para links, WebFetch.

3. **Extraia o cardápio** no schema abaixo. Regras:
   - Passe o `cardapio.yaml` atual como referência: se um item já existe e só mudou o preço, **mantenha o mesmo nome e a mesma posição**. Não duplique nem reordene sem motivo.
   - Preço é número em reais com ponto decimal (`45.00`). Sem `R$`, sem string.
   - **Preço ilegível ou ausente na fonte:** mantenha o valor antigo e marque com ⚠ no diff. Nunca invente preço.
   - Não crie itens que não estão nas fontes.
   - Informações de taxa de entrega, pedido mínimo, formas de pagamento e horário: se aparecerem com clareza, proponha atualizar o `info.yaml`, mas trate isso como uma pergunta separada no fim. Campos:
     - `taxa_entrega` (texto exibido, ex.: "Entrega R$ 5 no Centro") **e** `taxa_entrega_valor` (número, ex.: `5.00`; use `0` para grátis). O número entra na soma do pedido.
     - `pedido_minimo` (texto) e `pedido_minimo_valor` (número). O número dispara o aviso "faltam R$ X".
     - `pagamentos`, `horarios`.
   - Observações gerais do cardápio (borda, meio a meio, mínimo) vão em `observacoes`.

4. **Mostre o diff em português**, sem gravar nada ainda. Formato:

   ```
   Pizzaria do Zé, proposta de atualização

   Preços alterados
     Calabresa            R$ 49,00 → R$ 52,00
     Portuguesa           R$ 54,00 → R$ 56,00

   Itens novos
     + Pizza de Pequi     R$ 58,00

   Itens removidos (não achei nas fontes novas)
     - Banana com canela

   Atenção
     ⚠ Marguerita: preço ilegível na foto, mantive R$ 45,00

   info.yaml
     Horário sábado: 18:00 a 23:59 vira 18:00 a 00:30 (confirmar)
   ```

5. **Espere aprovação explícita** ("ok", "pode gravar", "aprovado"). Se o usuário pedir ajustes, refaça o diff. **Nunca grave sem o "ok".**

6. **Ao aprovar:**
   - Grave `restaurantes/<slug>/cardapio.yaml` com `atualizado_em` na data de hoje (formato `YYYY-MM-DD`).
   - Se o usuário aprovou mudanças de `info.yaml`, grave também.
   - Mantenha o YAML limpo: 2 espaços de indentação, sem aspas desnecessárias, `descricao` só quando existir.

7. **Feche** dizendo o que rodar: `npm run dev` para conferir no navegador, e (se for repositório git) sugira o commit.

## Schema do cardapio.yaml

```yaml
atualizado_em: "2026-09-07"      # data da última conferência
categorias:
  - nome: Pizzas grandes
    itens:
      - nome: Calabresa
        preco: 52.00             # número; opcional se o lugar não divulga preço
        descricao: Mussarela, calabresa e cebola   # opcional
observacoes: >-                  # opcional, texto livre
  Borda recheada + R$ 6. Meio a meio: valor da mais cara.
```

## Observações

- O site é estático: depois de gravar, roda `npm run build` e faz deploy pra ir ao ar.
- Não mexa em `restaurantes/<slug>/fontes/`. Os arquivos brutos ficam lá e não vão pro git.
- Se não houver `info.yaml` para o slug, o restaurante ainda não foi cadastrado: avise o usuário em vez de criar do zero (o cadastro inicial é manual, veja o README).
