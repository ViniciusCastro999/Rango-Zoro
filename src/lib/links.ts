const MSG_PADRAO = 'Olá! Gostaria de fazer um pedido.';

export function linkWhatsapp(numero: string, texto: string = MSG_PADRAO): string {
  const so = numero.replace(/\D/g, '');
  const completo = so.startsWith('55') ? so : `55${so}`;
  return `https://wa.me/${completo}?text=${encodeURIComponent(texto)}`;
}

export function formatarReal(n: number | undefined): string {
  if (n == null) return '';
  return n.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
}
