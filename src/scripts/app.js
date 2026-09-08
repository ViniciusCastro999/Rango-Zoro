import { statusAgora } from '../lib/horario.js';

// 1. Recalcula "aberto agora" no navegador (o build pode ter sido horas atrás).
function hidratarStatus() {
  document.querySelectorAll('[data-status]').forEach((el) => {
    let horarios = {};
    try {
      horarios = JSON.parse(el.dataset.horarios || '{}');
    } catch {
      /* mantém o que veio do servidor */
    }
    const s = statusAgora(horarios, {
      pausado: el.dataset.pausado === 'true',
      pausaMotivo: el.dataset.pausaMotivo || '',
    });
    el.textContent = s.texto;
    el.dataset.tom = s.tom;
    const card = el.closest('[data-card]');
    if (card) card.dataset.aberto = String(s.aberto);
    const zap = document.querySelector('[data-zap]');
    if (zap && el.dataset.principal === 'true') {
      zap.dataset.tom = s.tom;
    }
  });
  document.dispatchEvent(new Event('rz:status'));
}

// 2. Busca + filtro de categoria + "só abertos" na home.
function filtros() {
  const lista = document.querySelector('[data-lista]');
  if (!lista) return;

  const busca = document.querySelector('[data-busca]');
  const chips = [...document.querySelectorAll('[data-chip]')];
  const cards = [...lista.querySelectorAll('[data-card]')];
  const vazio = document.querySelector('[data-vazio]');
  let categoria = 'tudo';
  let soAbertos = false;

  function aplicar() {
    const q = (busca?.value || '').toLowerCase().trim();
    let visiveis = 0;
    cards.forEach((c) => {
      const ok =
        (!q || (c.dataset.busca || '').toLowerCase().includes(q)) &&
        (categoria === 'tudo' || c.dataset.categoria === categoria) &&
        (!soAbertos || c.dataset.aberto === 'true');
      c.closest('li').hidden = !ok;
      if (ok) visiveis += 1;
    });
    if (vazio) vazio.hidden = visiveis > 0;
  }

  busca?.addEventListener('input', aplicar);

  chips.forEach((chip) => {
    chip.addEventListener('click', () => {
      const abertosChip = chip.dataset.chip === '__abertos__';
      if (abertosChip) {
        soAbertos = chip.getAttribute('aria-pressed') !== 'true';
        chip.setAttribute('aria-pressed', String(soAbertos));
      } else {
        chips
          .filter((c) => c.dataset.chip !== '__abertos__')
          .forEach((c) => c.setAttribute('aria-pressed', 'false'));
        chip.setAttribute('aria-pressed', 'true');
        categoria = chip.dataset.chip || 'tudo';
      }
      aplicar();
    });
  });

  document.addEventListener('rz:status', aplicar);
  aplicar();
}

hidratarStatus();
filtros();
setInterval(hidratarStatus, 60_000);

// lugar que pede por site de fora: registra o clique do "Fazer pedido no site"
const irSite = document.querySelector('[data-ir-site]');
if (irSite) {
  irSite.addEventListener('click', () => {
    const g = window.goatcounter;
    if (g && typeof g.count === 'function') {
      g.count({
        path: 'pedido/' + irSite.dataset.slug,
        title: 'Pedido: ' + (irSite.dataset.nome || irSite.dataset.slug),
        event: true,
      });
      g.count({ path: 'pedido-site-externo', title: 'Pedido em site externo', event: true });
    }
  });
}
