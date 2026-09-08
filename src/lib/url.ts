// Prefixa caminhos internos com o base do site.
// No GitHub Pages o site fica em /Rango-Zoro/; no dev o base é /.
const BASE = import.meta.env.BASE_URL;

export function u(caminho = ''): string {
  const base = BASE.replace(/\/$/, '');
  const rel = caminho.replace(/^\//, '');
  if (!rel) return base || '/';
  return `${base}/${rel}`;
}
