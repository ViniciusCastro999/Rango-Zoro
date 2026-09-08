// Monta o pedido no cardápio (checkbox + quantidade + meio a meio, estilo recibo).
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

function esc(s) {
  return String(s).replace(
    /[&<>"]/g,
    (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' })[c],
  );
}

function linkWhatsapp(numero, texto) {
  const n = String(numero).replace(/\D/g, '');
  return `https://wa.me/${n.startsWith('55') ? n : '55' + n}?text=${encodeURIComponent(texto)}`;
}

function iniciar(wrap) {
  const { slug, nome, whatsapp, mensagemVazia } = wrap.dataset;
  const entregaCents = wrap.dataset.entrega === '' ? null : centavos(wrap.dataset.entrega);
  const minimoCents = wrap.dataset.minimo === '' ? null : centavos(wrap.dataset.minimo);
  const chave = 'rz:pedido:' + slug;

  const lis = [...document.querySelectorAll('.item[data-item]')];
  const chavesDom = new Set(lis.map((li) => li.dataset.item));
  const catsMM = new Set([...document.querySelectorAll('[data-mm]')].map((el) => el.dataset.cat));

  // carrinho: chave normal -> qtd (número); chave "mm:<cat>:<a> / <b>" -> {nome, precoCents, qtd}
  let carrinho = carregar();
  Object.keys(carrinho).forEach((k) => {
    if (k.startsWith('mm:')) {
      const cat = k.slice(3, k.indexOf(':', 3));
      if (!catsMM.has(cat)) delete carrinho[k];
    } else if (!chavesDom.has(k)) {
      delete carrinho[k];
    }
  });

  function carregar() {
    try {
      const bruto = JSON.parse(sessionStorage.getItem(chave)) || {};
      const limpo = {};
      for (const [k, v] of Object.entries(bruto)) {
        if (k.startsWith('mm:') && v && typeof v === 'object') {
          const q = Math.min(MAX_QTD, Math.max(0, parseInt(v.qtd, 10) || 0));
          if (q > 0 && v.a && v.b && v.precoCents) {
            limpo[k] = { a: v.a, b: v.b, precoCents: v.precoCents, qtd: q };
          }
        } else {
          const n = Math.min(MAX_QTD, Math.max(0, parseInt(v, 10) || 0));
          if (n > 0) limpo[k] = n;
        }
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

  // ---------- itens normais (checkbox) ----------
  lis.forEach((li) => {
    const key = li.dataset.item;
    const precoCents = centavos(li.dataset.preco);
    const toggle = li.querySelector('[data-toggle]');
    const qtdbox = li.querySelector('[data-qtdbox]');
    const qtdEl = li.querySelector('[data-qtd]');
    const precoCell = li.querySelector('[data-preco-cell]');
    const precoUnit = precoCell.textContent.trim();

    const qtd = () => (typeof carrinho[key] === 'number' ? carrinho[key] : 0);

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

  // ---------- meio a meio ----------
  function setMM(key, meta, q) {
    q = Math.max(0, Math.min(MAX_QTD, q));
    if (q === 0) {
      delete carrinho[key];
    } else {
      const antigo = carrinho[key] || {};
      carrinho[key] = {
        a: meta.a ?? antigo.a,
        b: meta.b ?? antigo.b,
        precoCents: meta.precoCents ?? antigo.precoCents,
        qtd: q,
      };
    }
    salvar();
    renderMM();
    atualizar();
  }

  function renderMM() {
    document.querySelectorAll('[data-mm]').forEach((mm) => {
      const cat = mm.dataset.cat;
      const ul = mm.closest('.cardapio__cat').querySelector('.cardapio__itens');
      ul.querySelectorAll('.item--mm').forEach((li) => li.remove());

      Object.entries(carrinho)
        .filter(([k]) => k.startsWith('mm:' + cat + ':'))
        .forEach(([k, v]) => {
          const li = document.createElement('li');
          li.className = 'item item--mm item--ativo';
          const preco = v.qtd > 1 ? brl(v.precoCents * v.qtd) : brl(v.precoCents);
          const rotulo = `meio a meio: ${v.a} / ${v.b}`;
          li.innerHTML = `
            <div class="item__linha">
              <button type="button" class="item__toggle" data-mm-toggle aria-pressed="true" aria-label="Tirar ${esc(rotulo)}">
                <span class="item__caixa" aria-hidden="true"></span>
                <span class="item__nome">${esc(rotulo)}</span>
              </button>
              <span class="item__dots" aria-hidden="true"></span>
              <span class="item__qtd">
                <button type="button" data-mm-menos aria-label="Menos um">-</button>
                <span data-mm-qtd>${v.qtd}</span>
                <button type="button" data-mm-mais aria-label="Mais um">+</button>
              </span>
              <span class="item__preco">${preco}</span>
            </div>`;
          li.querySelector('[data-mm-toggle]').addEventListener('click', () => setMM(k, {}, 0));
          li.querySelector('[data-mm-menos]').addEventListener('click', () =>
            setMM(k, {}, (carrinho[k]?.qtd || 0) - 1),
          );
          li.querySelector('[data-mm-mais]').addEventListener('click', () =>
            setMM(k, {}, (carrinho[k]?.qtd || 0) + 1),
          );
          ul.prepend(li);
        });
    });
  }

  document.querySelectorAll('[data-mm]').forEach((mm) => {
    const cat = mm.dataset.cat;
    const selA = mm.querySelector('[data-mm-a]');
    const selB = mm.querySelector('[data-mm-b]');
    const btn = mm.querySelector('[data-mm-add]');

    function podeAdd() {
      btn.disabled = !selA.value || !selB.value || selA.value === selB.value;
    }
    selA.addEventListener('change', podeAdd);
    selB.addEventListener('change', podeAdd);
    podeAdd();

    btn.addEventListener('click', () => {
      const a = selA.value;
      const b = selB.value;
      if (!a || !b || a === b) return;
      const pa = centavos(selA.selectedOptions[0].dataset.preco);
      const pb = centavos(selB.selectedOptions[0].dataset.preco);
      const [x, y] = [a, b].sort((m, n) => m.localeCompare(n, 'pt-BR'));
      const key = `mm:${cat}:${x} / ${y}`;
      const atual = carrinho[key]?.qtd || 0;
      setMM(key, { a: x, b: y, precoCents: Math.max(pa, pb) }, atual + 1);
      selA.value = '';
      selB.value = '';
      podeAdd();
      mm.closest('.cardapio__cat').open = true;
    });
  });

  renderMM();

  // registra o clique no "Pedir no WhatsApp"
  zap.addEventListener('click', () => {
    const g = window.goatcounter;
    if (g && typeof g.count === 'function') {
      g.count({ path: 'pedido/' + slug, title: 'Pedido: ' + (nome || slug), event: true });
      if (itensDoPedido().length > 0) {
        g.count({ path: 'pedido-com-itens', title: 'Pedido com itens marcados', event: true });
      }
    }
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
    const out = [];
    lis.forEach((li) => {
      const q = carrinho[li.dataset.item];
      if (typeof q === 'number' && q > 0) {
        out.push({ nome: li.dataset.nome, qtd: q, precoCents: centavos(li.dataset.preco) });
      }
    });
    Object.entries(carrinho).forEach(([k, v]) => {
      if (k.startsWith('mm:') && v && v.qtd > 0) {
        out.push({ mm: true, a: v.a, b: v.b, qtd: v.qtd, precoCents: v.precoCents });
      }
    });
    return out;
  }

  // linha do pedido no texto do WhatsApp: "X-Tudo", "2 X-Tudo",
  // "uma pizza metade Calabresa e metade Portuguesa", "2 pizzas metade ..."
  function linhaPedido(i) {
    if (i.mm) {
      return i.qtd === 1
        ? `uma pizza metade ${i.a} e metade ${i.b}`
        : `${i.qtd} pizzas metade ${i.a} e metade ${i.b}`;
    }
    return i.qtd === 1 ? i.nome : `${i.qtd} ${i.nome}`;
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
    const texto =
      'Gostaria de pedir:\n\n' + itens.map((i) => `- ${linhaPedido(i)}`).join('\n');
    zap.href = linkWhatsapp(whatsapp, texto);
    zap.textContent = `Pedir no WhatsApp · ${brl(totalCents)}`;
  }

  atualizar();
}
