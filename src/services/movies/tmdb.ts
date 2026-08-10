import { env } from "@/lib/env";

const base = "https://api.themoviedb.org/3";
export async function tmdb<T>(path: string, params: Record<string, string> = {}): Promise<T> {
  if (!env.TMDB_API_KEY) throw new Error("TMDB_API_KEY is not configured");
  const query = new URLSearchParams({ api_key: env.TMDB_API_KEY, language: "en-US", ...params });
  const response = await fetch(`${base}${path}?${query}`, { next: { revalidate: 1800 } });
  if (!response.ok) throw new Error(`TMDB request failed (${response.status})`);
  return response.json() as Promise<T>;
}
