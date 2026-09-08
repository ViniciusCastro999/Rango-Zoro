import { createClient, type SupabaseClient } from '@supabase/supabase-js';

export const SUPABASE_URL = import.meta.env.PUBLIC_SUPABASE_URL as string | undefined;
export const SUPABASE_ANON = import.meta.env.PUBLIC_SUPABASE_ANON_KEY as string | undefined;

/** true quando o site está ligado no Supabase (produção e dev com .env). */
export const temSupabase = !!(SUPABASE_URL && SUPABASE_ANON);

let _cliente: SupabaseClient | null = null;

/** Cliente do navegador (auth no /admin, leitura ao vivo). Só chame se temSupabase. */
export function supabase(): SupabaseClient {
  if (!temSupabase) throw new Error('Supabase não configurado (falta PUBLIC_SUPABASE_URL / _ANON_KEY)');
  _cliente ??= createClient(SUPABASE_URL!, SUPABASE_ANON!, {
    auth: { persistSession: true, autoRefreshToken: true },
  });
  return _cliente;
}
