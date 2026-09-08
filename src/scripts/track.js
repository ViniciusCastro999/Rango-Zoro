// Manda um evento pro GoatCounter, se ele estiver na página (só na versão publicada).
// Em dev o script não carrega, então isto vira um no-op sem erro.
export function track(path, titulo) {
  const g = window.goatcounter;
  if (g && typeof g.count === 'function') {
    g.count({ path, title: titulo || path, event: true });
  }
}
