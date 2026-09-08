// Monta o pedido no cardápio (checkbox + quantidade, estilo recibo).
// Soma itens e entrega, e gera o link do WhatsApp com a lista e as quantidades.
// Não manda valores no texto: a loja calcula. Só roda na página do restaurante.

const wrap = document.querySelector('[data-pedido]');
if (wrap) iniciar(wrap);

const MAX_QTD = 20;

function brl(cents) {
  return (cents / 100).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
}

function centavos(valor) {
  return Math.round(parseFloat(valor) * 100);
}

function linkWhatsapp(numero, texto) {
  const n = String(numero).replace(/\D/g, '');
  return `https://wa.me/${n.startsWith('55') ? n : '55' + n}?text=${encodeURIComponent(texto)}`;
}

function iniciar(wrap) {
  const { slug, whatsapp, mensagemVazia } = wrap.dataset;
  const entregaCents = wrap.dataset.entrega === '' ? null : centavos(wrap.dataset.entrega);
  const minimoCents = wrap.dataset.minimo === '' ? null : centavos(wrap.dataset.minimo);
  const chave = 'rz:pedido:' + slug;

  const lis = [...document.querySelectorAll('.item[data-item]')];
  const chavesDom = new Set(lis.map((li) => li.dataset.item));

  let carrinho = carregar();
  Object.keys(carrinho).forEach((k) => chavesDom.has(k) || delete carrinho[k]);

  function carregar() {
    try {
      const bruto = JSON.parse(sessionStorage.getItem(chave)) || {};
      const limpo = {};
      for (const [k, v] of Object.entries(bruto)) {
        const n = Math.min(MAX_QTD, Math.max(0, parseInt(v, 10) || 0));
        if (n > 0) limpo[k] = n;
      }
      return limpo;
    } catch {
      return {};
    }
  }
  function salvar() {
    try {
      sessionStorage.setItem(chave, JSON.stringify(carrinho));
    } catch {
      /* modo privado, tudo bem */
    }
  }

  const resumo = wrap.querySelector('[data-resumo]');
  const elItens = wrap.querySelector('[data-resumo-itens]');
  const elTotal = wrap.querySelector('[data-resumo-total]');
  const zap = wrap.querySelector('[data-zap]');

  const recibo = document.querySelector('[data-recibo]');
  const rSub = recibo?.querySelector('[data-r-sub]');
  const rEnt = recibo?.querySelector('[data-r-ent]');
  const rTot = recibo?.querySelector('[data-r-tot]');
  const rAviso = recibo?.querySelector('[data-r-aviso]');

  lis.forEach((li) => {
    const key = li.dataset.item;
    const precoCents = centavos(li.dataset.preco);
    const toggle = li.querySelector('[data-toggle]');
    const qtdbox = li.querySelector('[data-qtdbox]');
    const qtdEl = li.querySelector('[data-qtd]');
    const precoCell = li.querySelector('[data-preco-cell]');
    const precoUnit = precoCell.textContent.trim();

    const qtd = () => carrinho[key] || 0;

    function set(q) {
      q = Math.max(0, Math.min(MAX_QTD, q));
      if (q === 0) delete carrinho[key];
      else carrinho[key] = q;
      salvar();
      pintar();
      atualizar();
    }

    function pintar() {
      const q = qtd();
      li.classList.toggle('item--ativo', q > 0);
      toggle.setAttribute('aria-pressed', String(q > 0));
      qtdbox.hidden = q === 0;
      qtdEl.textContent = q || 1;
      precoCell.textContent = q > 1 ? brl(precoCents * q) : precoUnit;
    }

    toggle.addEventListener('click', () => set(qtd() > 0 ? 0 : 1));
    li.querySelector('[data-menos]').addEventListener('click', () => set(qtd() - 1));
    li.querySelector('[data-mais]').addEventListener('click', () => set(qtd() + 1));
    pintar();
  });

  // abre as seções que já têm item marcado
  document.querySelectorAll('.cardapio__cat').forEach((sec) => {
    if (sec.querySelector('.item--ativo')) sec.open = true;
  });

  // botão "abrir todas / fechar todas"
  const abrirTudo = document.querySelector('[data-abrir-tudo]');
  if (abrirTudo) {
    abrirTudo.addEventListener('click', () => {
      const abrir = abrirTudo.getAttribute('aria-expanded') !== 'true';
      document.querySelectorAll('.cardapio__cat').forEach((sec) => {
        sec.open = abrir;
      });
      abrirTudo.setAttribute('aria-expanded', String(abrir));
      abrirTudo.textContent = abrir ? 'fechar todas' : 'abrir todas';
    });
  }

  function textoEntrega(cents) {
    if (cents == null) return 'a combinar';
    return cents === 0 ? 'grátis' : brl(cents);
  }

  function itensDoPedido() {
    return lis
      .filter((li) => carrinho[li.dataset.item])
      .map((li) => ({
        nome: li.dataset.nome,
        qtd: carrinho[li.dataset.item],
        precoCents: centavos(li.dataset.preco),
      }));
  }

  function atualizar() {
    const itens = itensDoPedido();
    const unidades = itens.reduce((s, i) => s + i.qtd, 0);
    const subCents = itens.reduce((s, i) => s + i.precoCents * i.qtd, 0);
    const somaEntrega = entregaCents && unidades > 0 ? entregaCents : 0;
    const totalCents = subCents + somaEntrega;

    if (unidades === 0) {
      resumo.hidden = true;
      if (recibo) recibo.hidden = true;
      zap.href = linkWhatsapp(whatsapp, mensagemVazia);
      zap.textContent = 'Pedir no WhatsApp';
      return;
    }

    resumo.hidden = false;
    elItens.textContent = `${unidades} ${unidades === 1 ? 'item' : 'itens'}`;
    elTotal.textContent = brl(totalCents);

    if (recibo) {
      recibo.hidden = false;
      rSub.textContent = brl(subCents);
      rEnt.textContent = textoEntrega(entregaCents);
      rTot.textContent = brl(totalCents);
      if (rAviso) {
        const falta = minimoCents == null ? 0 : minimoCents - subCents;
        rAviso.hidden = falta <= 0;
        if (falta > 0) rAviso.textContent = `Faltam ${brl(falta)} pro pedido mínimo`;
      }
    }

    // Mensagem do WhatsApp: só item e quantidade, sem valores (a loja calcula).
    const texto = 'Gostaria de pedir:\n\n' + itens.map((i) => `${i.qtd}x ${i.nome}`).join('\n');
    zap.href = linkWhatsapp(whatsapp, texto);
    zap.textContent = `Pedir no WhatsApp · ${brl(totalCents)}`;
  }

  atualizar();
}
