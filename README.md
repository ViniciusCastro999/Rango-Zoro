# RangoZoro

Guia de todo lugar que faz e entrega comida em **Conceição dos Ouros, MG** (a cidade que
todo mundo chama de **Zoro**). Não é app de entrega: mostra quem está aberto agora e manda
o pedido direto pro WhatsApp do restaurante. Sem comissão, sem intermediar pagamento.

Site: **https://viniciuscastro999.github.io/Rango-Zoro/**

- Identidade visual e voz: [`IDENTIDADE.md`](IDENTIDADE.md)
- Kit de Instagram: [`identidade/instagram/legendas.md`](identidade/instagram/legendas.md)
- Plano de conteúdo: [`instagram/PLANO.md`](instagram/PLANO.md)

## Rodar

```bash
npm install
npm run dev      # http://localhost:4321/Rango-Zoro
npm run build    # gera dist/ (site estático)
npm run check    # checagem de tipos
```

Precisa de Node 18 ou mais novo.

## Como os dados funcionam

Cada lugar é uma pasta em `restaurantes/`:

```
restaurantes/
  pizzaria-do-ze/
    info.yaml        # nome, WhatsApp, bairro, horário, taxa (editado à mão)
    cardapio.yaml    # itens e preços (gerado pelo /sync-cardapio, revisado por você)
    fontes/          # fotos, prints e PDFs do cardápio (não vão pro git)
```

O site é gerado desses YAMLs no `npm run build`. Não tem banco de dados nem painel.

### Adicionar um restaurante novo

1. Crie `restaurantes/<slug>/` (slug em minúsculo com hífens, ex.: `acai-da-esquina`).
2. Copie um `info.yaml` existente e ajuste. Campos que importam:
   - `whatsapp`: só dígitos, com `55` na frente, ex.: `"5535999990001"`.
   - `site_pedido`: use no lugar do `whatsapp` quando o restaurante recebe pedido por um
     site de fora (Anota AI, Goomer, site próprio). Nesse caso o RangoZoro só mostra um
     botão que leva pra lá, o cardápio fica só pra ver (sem montar a lista) e não tem
     total. Exemplo: `restaurantes/marmitex-da-cida/`.
   - `taxa_entrega` (texto) e `taxa_entrega_valor` (número, `0` para grátis): o número é
     somado no total do pedido montado no cardápio. Sem ele, a entrega aparece como
     "a combinar".
   - `pedido_minimo` (texto) e `pedido_minimo_valor` (número): mostra "faltam R$ X" no
     recibo.
   - `horarios`: por dia, `["18:00", "23:00"]`, ou `null` se fecha. Vira o dia seguinte?
     `["18:00", "00:30"]`. Dois turnos? `[["11:00","14:00"], ["18:00","23:00"]]`.
   - `destaque: true` põe o lugar no topo com selo "em alta".
   - `pausado: true` mais `pausa_motivo: "..."` quando o lugar fecha por uns dias.
3. Jogue as fotos do cardápio em `restaurantes/<slug>/fontes/` e rode `/sync-cardapio <slug>`
   no Claude Code. Ou escreva o `cardapio.yaml` à mão (schema em
   `.claude/skills/sync-cardapio/SKILL.md`).

### Atualizar um cardápio

Jogue o material novo em `restaurantes/<slug>/fontes/` e rode `/sync-cardapio <slug>`. O
diff aparece em português e o arquivo só é gravado depois do seu "ok". Nada vai pro ar até
`npm run build` mais deploy.

## Deploy

O site é estático (`dist/`) e sai no GitHub Pages pelo workflow em
[`.github/workflows/deploy.yml`](.github/workflows/deploy.yml): todo push na branch `main`
faz build e publica.

Uma vez, nas configurações do repositório: **Settings > Pages > Source: GitHub Actions**.

O `base` do site (`/Rango-Zoro`) está em [`astro.config.mjs`](astro.config.mjs). Se o repo
mudar de nome ou for pra domínio próprio, ajuste ali.

## Marca

Os SVGs em `public/marca/` e `public/favicon.svg` são gerados por
[`identidade/logos/gerar-marca.mjs`](identidade/logos/gerar-marca.mjs) com o texto já em
contornos. Instruções no topo do arquivo.

## Números de acesso

O site usa **GoatCounter** (grátis, sem cookie, sem banner de privacidade). Ele conta:

- quantas pessoas entram e em que páginas (cada página de restaurante mostra o interesse
  naquele lugar);
- um evento **`pedido/<slug>`** toda vez que alguém clica em "Pedir no WhatsApp", pra você
  ver de qual restaurante vem mais pedido.

Pra ligar: criar conta em https://goatcounter.com com o código `rangozoro` (ou outro, daí
troque `CONTADOR` em `src/layouts/Base.astro`). O painel fica em
`https://rangozoro.goatcounter.com`. O script só roda no site publicado, não no `npm run dev`.

## Pendências antes de divulgar

- [ ] Os 3 lugares em `restaurantes/` são exemplos com WhatsApp fake
      (`5535999990001` a `5535999990003`). Trocar pelos reais ou apagar quando entrar
      restaurante de verdade.
- [ ] Definir o WhatsApp oficial do RangoZoro em
      [`src/pages/sobre.astro`](src/pages/sobre.astro) (`CONTATO`).
- [ ] `public/marca/og.svg` funciona no preview de link, mas alguns apps só aceitam PNG.
      Se quiser, exportar um `og.png` 1200x630 e apontar nele no `src/layouts/Base.astro`.
