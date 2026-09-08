// Lógica de "aberto agora" no fuso do Zoro (America/Sao_Paulo).
// JS puro de propósito: roda no build (Astro/Node) e no navegador sem duplicar.

const DIAS = ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sab'];
const NOMES = {
  seg: 'segunda', ter: 'terça', qua: 'quarta', qui: 'quinta',
  sex: 'sexta', sab: 'sábado', dom: 'domingo',
};

/** Aceita ["18:00","23:00"] ou [["11:00","14:00"],["18:00","23:00"]] ou null. */
function faixasDoDia(valor) {
  if (!valor || !valor.length) return [];
  return typeof valor[0] === 'string' ? [valor] : valor;
}

function minutos(hhmm) {
  const [h, m] = String(hhmm).split(':').map(Number);
  return h * 60 + m;
}

/** Dia da semana (0=dom) e minutos desde a meia-noite, agora, no Zoro. */
export function agoraEmZoro(date = new Date()) {
  const partes = Object.fromEntries(
    new Intl.DateTimeFormat('en-US', {
      timeZone: 'America/Sao_Paulo',
      weekday: 'short', hour: '2-digit', minute: '2-digit', hour12: false,
    })
      .formatToParts(date)
      .map((p) => [p.type, p.value]),
  );
  const mapa = { Sun: 0, Mon: 1, Tue: 2, Wed: 3, Thu: 4, Fri: 5, Sat: 6 };
  const hora = Number(partes.hour) % 24;
  return { diaIdx: mapa[partes.weekday], min: hora * 60 + Number(partes.minute) };
}

/**
 * @param {Record<string, any>} horarios  mapa seg..dom -> faixas ou null
 * @param {{pausado?: boolean, pausaMotivo?: string}} [opcoes]
 * @returns {{aberto: boolean, texto: string, tom: 'aberto'|'fechado'|'pausado'}}
 */
export function statusAgora(horarios = {}, opcoes = {}, date = new Date()) {
  if (opcoes.pausado) {
    return { aberto: false, texto: opcoes.pausaMotivo || 'Fechado no momento', tom: 'pausado' };
  }

  const { diaIdx, min } = agoraEmZoro(date);
  const hoje = DIAS[diaIdx];
  const ontem = DIAS[(diaIdx + 6) % 7];

  // Fechou depois da meia-noite? (faixa de ontem que cruza 00h)
  for (const [abre, fecha] of faixasDoDia(horarios[ontem])) {
    if (minutos(fecha) < minutos(abre) && min < minutos(fecha)) {
      return { aberto: true, texto: `Aberto até ${fecha}`, tom: 'aberto' };
    }
  }

  let proximaHoje = null;
  for (const [abre, fecha] of faixasDoDia(horarios[hoje])) {
    const ini = minutos(abre);
    const fim = minutos(fecha);
    const cruzaMeiaNoite = fim <= ini;
    if (min >= ini && (cruzaMeiaNoite || min < fim)) {
      return { aberto: true, texto: `Aberto até ${fecha}`, tom: 'aberto' };
    }
    if (min < ini && proximaHoje === null) proximaHoje = abre;
  }
  if (proximaHoje) {
    return { aberto: false, texto: `Abre hoje ${proximaHoje}`, tom: 'fechado' };
  }

  // Já passou tudo hoje: procura o próximo dia com horário.
  for (let i = 1; i <= 7; i++) {
    const d = DIAS[(diaIdx + i) % 7];
    const faixas = faixasDoDia(horarios[d]);
    if (faixas.length) {
      const quando = i === 1 ? 'amanhã' : NOMES[d];
      return { aberto: false, texto: `Abre ${quando} ${faixas[0][0]}`, tom: 'fechado' };
    }
  }
  return { aberto: false, texto: 'Sem horário informado', tom: 'fechado' };
}

/** Lista seg..dom já formatada, pra tabela na página do restaurante. */
export function horarioSemana(horarios = {}) {
  return ['seg', 'ter', 'qua', 'qui', 'sex', 'sab', 'dom'].map((d) => {
    const faixas = faixasDoDia(horarios[d]);
    return {
      dia: NOMES[d],
      texto: faixas.length ? faixas.map(([a, b]) => `${a} às ${b}`).join(' e ') : 'Fechado',
      fechado: faixas.length === 0,
    };
  });
}
