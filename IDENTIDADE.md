# Identidade RangoZoro

Guia visual e de voz. O site, o Instagram e qualquer arte seguem isto.

## O que é

RangoZoro é o guia de todo lugar que faz comida em **Conceição dos Ouros, MG** (a cidade
que todo mundo chama de **Zoro**), pop. ~12 mil. Não é app de entrega. É o lugar onde você
vê tudo que a cidade tem, quem está aberto agora, e pede direto no WhatsApp do
restaurante.

O valor é **descoberta**: "eu nem sabia que esse lugar existia". Muitos são conhecidos só
no próprio bairro. O RangoZoro junta todo mundo na mesma tela.

## Público e contexto de uso

Morador da cidade, no celular, de noite, com fome, decidindo onde pedir. Nunca no
computador. A tela precisa abrir rápido no 4G e ser legível de primeira.

## Personalidade

Da cidade, informal, com bom humor. É "coisa nossa", não startup. Fala como vizinho que
manja de todos os cantos, não como aplicativo. Perto de meme local, longe de corporativo.

## Cores

Paleta de comida de interior de Minas: toldo de lanchonete, pequi, mesa de bar, quentão.
Sem o clichê creme com serifa e terracota.

| Token            | Hex       | Uso                                                        |
|------------------|-----------|-----------------------------------------------------------|
| `--brasa`        | `#D62D20` | Cor de marca. Botão "Pedir no WhatsApp", tag "Zoro", topo. |
| `--brasa-escura` | `#A81F16` | Estados pressionados, texto sobre pequi.                   |
| `--pequi`        | `#F2A81D` | Secundária quente. Destaques, selo "em alta", detalhes.    |
| `--folha`        | `#1E7A46` | Sinal de "aberto agora". Só status, nunca decoração.       |
| `--tinta`        | `#2B1B12` | Texto. Preto-cacau quente, não preto-azulado.              |
| `--creme`        | `#F9EFD6` | Fundo da página. Miolo de pão de queijo.                   |
| `--papel`        | `#FFFFFF` | Superfície dos cards e do cardápio (folha de menu).        |
| `--linha`        | `#E7D4A8` | Divisórias, pontilhado do cardápio.                        |

Contraste: `--tinta` sobre `--creme` e sobre `--papel` passa AA. Texto branco só sobre
`--brasa`, `--brasa-escura` ou `--folha`.

## Tipografia

Três famílias, cada uma com um papel claro.

- **Títulos, Darker Grotesque** (800/900). Alta e forte, com cara de lousa de lanchonete.
  Nome do site, nome dos restaurantes, títulos de categoria do cardápio.
- **Texto e interface, Hanken Grotesque** (400 a 700). Neutra, ótima em corpo pequeno no
  celular. Descrições, botões, textos longos.
- **Números e recibo, Courier Prime** (700). Preços, status ("aberto até 23h"), taxas,
  as linhas tracejadas. É o que dá o ar de nota fiscal.

Sem: caixa-alta em rótulos, palavra solta colorida no meio do título, rótulo tipográfico
em cima de cada bloco.

## Marca

Logotipo tipográfico: **rangozoro.** numa palavra só, tudo minúsculo, em Darker Grotesque
900 com tracking bem fechado. "rango" em `--tinta`, "zoro" em `--brasa`, e o ponto final
em `--pequi`. O ponto é o único detalhe de cor e o gancho da marca.

- Arquivo: `public/marca/logo-rangozoro.svg`
- No cabeçalho do site (barra `--brasa`): "rango" em `--tinta`, "zoro" em `--creme`, ponto
  em `--pequi`.
- Ícone (`public/favicon.svg`): **rz.** em quadrado `--tinta` de cantos arredondados,
  "r" creme, "z" `--brasa`, ponto `--pequi`.
- Foto de perfil do Instagram (`identidade/instagram/img/perfil.png`): estilo cupom, "RZ"
  em Courier Prime entre duas linhas `====`, fundo `--tinta`.

Os SVGs de marca já vêm com o texto convertido em contornos, pra não depender de webfont
onde SVG não carrega fonte. Pra regerar depois de mudar cor ou tracking:
`node identidade/logos/gerar-marca.mjs` (instruções no topo do arquivo). Outras direções
exploradas ficam em `identidade/logos/galeria.html`.

## Voz (escrita)

- Frase curta, verbo direto, caixa normal. "Pedir no WhatsApp", não "Enviar pedido".
- "Achou, pediu no zap." "Todo rango do Zoro num lugar só."
- A cidade é **o Zoro**: "sou do Zoro", "restaurante do Zoro", "pedir comida no Zoro".
- Nada de travessão no meio da frase. Usa vírgula, ponto ou parênteses.
- Vazio e erro dão direção, sem drama: "Cardápio ainda não catalogado. Chama no WhatsApp
  que eles te passam tudo."
- Deixar claro o modelo, sempre: "A gente não entrega nem cobra comissão. O pedido é
  direto com o restaurante."
