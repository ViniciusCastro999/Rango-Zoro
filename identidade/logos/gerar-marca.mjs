// Gera os SVGs da marca (wordmark, favicon, og) com o texto ja convertido em
// contornos, pra nao depender de webfont onde SVG nao carrega fonte.
//
// Pré-requisitos:
//   npm i -D opentype.js
//   curl -sL "https://fonts.gstatic.com/s/darkergrotesque/v10/U9MK6cuh-mLQlC4BKCtayOfARkSVgb381b-W8-QDqXyerX7y.ttf" -o /tmp/dg900.ttf
// Rodar da raiz do projeto:
//   node identidade/logos/gerar-marca.mjs
import * as otMod from 'opentype.js/dist/opentype.mjs';
import fs from 'node:fs';
import path from 'node:path';

const opentype = otMod.default ?? otMod;
const font = opentype.parse(fs.readFileSync('/tmp/dg900.ttf').buffer);
const OUT = path.resolve(import.meta.dirname, '../..');

function run(text, size, x0 = 0, track = -0.055) {
  const TRACK = track * size;
  let x = x0;
  const parts = [];
  for (const ch of text) {
    const p = font.getPath(ch, 0, 0, size);
    const d = p.toPathData(2);
    if (d && d !== 'Z') parts.push({ d, x });
    x += font.getAdvanceWidth(ch, size) + TRACK;
  }
  return { parts, width: x - TRACK - x0 };
}

function group(segments, size, track = -0.055) {
  // segments: [{text, fill}]  -> {inner, width}
  let x = 0;
  const inner = [];
  for (const s of segments) {
    const r = run(s.text, size, x, track);
    for (const g of r.parts) inner.push(`<path fill="${s.fill}" transform="translate(${g.x.toFixed(2)})" d="${g.d}"/>`);
    x += r.width + track * size; // mesmo tracking entre segmentos que entre letras
  }
  return { inner: inner.join("\n    "), width: x - track * size };
}

const CAP = 0.80; // topo aprox das minúsculas altas da DG, relativo ao size

// ---------- wordmark ----------
{
  const size = 100;
  const g = group([{ text: 'rango', fill: '#2b1b12' }, { text: 'zoro', fill: '#d62d20' }], size);
  const pad = 6;
  const dotR = 0.085 * size;
  const dotCx = g.width + dotR * 0.55;
  const boxH = CAP * size + pad * 2;
  const totalW = dotCx + dotR + pad;
  fs.writeFileSync(`${OUT}/public/marca/logo-rangozoro.svg`,
`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${totalW.toFixed(1)} ${boxH.toFixed(1)}" role="img" aria-label="RangoZoro">
  <g transform="translate(${pad} ${(CAP * size + pad).toFixed(1)})">
    ${g.inner}
    <circle cx="${dotCx.toFixed(1)}" cy="-4" r="${dotR.toFixed(1)}" fill="#f2a81d"/>
  </g>
</svg>
`);
}

// ---------- ícone "rz." (fundo vermelho) ----------
// usado no favicon (64) e na foto de perfil do Instagram (1080)
function iconeRz(lado, raio) {
  const size = 100;
  const g = group([{ text: 'r', fill: '#f9efd6' }, { text: 'z', fill: '#2b1b12' }], size);
  const r = 0.085 * size;
  const dotCx = g.width + r * 0.55;
  const cW = dotCx + r;
  const cH = CAP * size;
  const alvo = lado * 0.62;
  const scale = alvo / Math.max(cW, cH);
  const gx = (lado - cW * scale) / 2;
  const gy = (lado - cH * scale) / 2 + cH * scale;
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${lado} ${lado}" role="img" aria-label="RangoZoro">
  <rect width="${lado}" height="${lado}" rx="${raio}" fill="#d62d20"/>
  <g transform="translate(${gx.toFixed(2)} ${gy.toFixed(2)}) scale(${scale.toFixed(4)})">
    ${g.inner}
    <circle cx="${dotCx.toFixed(1)}" cy="-4" r="${r.toFixed(1)}" fill="#f2a81d"/>
  </g>
</svg>
`;
}

fs.writeFileSync(`${OUT}/public/favicon.svg`, iconeRz(64, 14));
fs.writeFileSync(`${OUT}/identidade/instagram/perfil-instagram.svg`, iconeRz(1080, 0));

// ---------- OG 1200x630 ----------
{
  const wm = group([{ text: 'rango', fill: '#2b1b12' }, { text: 'zoro', fill: '#d62d20' }], 132);
  const wmDotR = 0.085 * 132;
  const wmDotCx = wm.width + wmDotR * 0.55;
  const l1 = group([{ text: 'Todo rango do Zoro', fill: '#2b1b12' }], 92);
  const l2 = group([{ text: 'num lugar só', fill: '#2b1b12' }], 92);
  fs.writeFileSync(`${OUT}/public/marca/og.svg`,
`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 630" role="img" aria-label="RangoZoro, todo rango do Zoro num lugar só">
  <rect width="1200" height="630" fill="#f9efd6"/>
  <rect width="1200" height="14" fill="#d62d20"/>
  <g transform="translate(80 190)">
    ${wm.inner}
    <circle cx="${wmDotCx.toFixed(1)}" cy="-5" r="${wmDotR.toFixed(1)}" fill="#f2a81d"/>
  </g>
  <line x1="82" y1="240" x2="640" y2="240" stroke="#e7d4a8" stroke-width="3" stroke-dasharray="4 7"/>
  <text x="84" y="288" font-family="'Courier New',monospace" font-size="26" letter-spacing="6" fill="#6b5546">DELIVERY · CONCEIÇÃO DOS OUROS-MG</text>
  <g transform="translate(80 430)">${l1.inner}</g>
  <g transform="translate(80 528)">${l2.inner}</g>
  <text x="84" y="586" font-family="system-ui,-apple-system,'Helvetica Neue',sans-serif" font-size="32" fill="#6b5546">Achou, pediu no zap. Sem app, sem cadastro.</text>
</svg>
`);
}

console.log('brand assets gerados');
