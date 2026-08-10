import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const cors = { "Access-Control-Allow-Origin": "*", "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type" };
Deno.serve(async request => {
  if (request.method === "OPTIONS") return new Response("ok", { headers: cors });
  const auth = request.headers.get("Authorization") ?? "";
  const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
  const anon = createClient(supabaseUrl, Deno.env.get("SUPABASE_ANON_KEY")!, { global: { headers: { Authorization: auth } } });
  const { data: { user } } = await anon.auth.getUser();
  if (!user) return Response.json({ error: "Unauthorized" }, { status: 401, headers: cors });

  const tmdbKey = Deno.env.get("TMDB_API_KEY");
  if (!tmdbKey) return Response.json({ error: "TMDB_API_KEY is not configured" }, { status: 503, headers: cors });
  const { category = "popular", type = "movie", page = 1 } = await request.json().catch(() => ({}));
  const allowedCategories = new Set(["popular", "top_rated", "upcoming", "now_playing", "on_the_air"]);
  const safeCategory = allowedCategories.has(category) ? category : "popular";
  const safeType = type === "tv" ? "tv" : "movie";
  const response = await fetch(`https://api.themoviedb.org/3/${safeType}/${safeCategory}?language=en-US&page=${Math.max(1, Number(page))}`, { headers: { Authorization: `Bearer ${tmdbKey}` } });
  if (!response.ok) return Response.json({ error: `TMDB returned ${response.status}` }, { status: 502, headers: cors });
  const payload = await response.json();
  const rows = payload.results.map((item: Record<string, unknown>) => ({
    tmdb_id: item.id,
    type: safeType === "tv" ? "series" : "movie",
    title: item.title ?? item.name,
    original_title: item.original_title ?? item.original_name,
    overview: item.overview,
    poster_path: item.poster_path,
    backdrop_path: item.backdrop_path,
    release_date: item.release_date || item.first_air_date || null,
    external_rating: item.vote_average,
    popularity: item.popularity,
    updated_at: new Date().toISOString(),
  }));
  const admin = createClient(supabaseUrl, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);
  const { data, error } = await admin.from("titles").upsert(rows, { onConflict: "tmdb_id,type" }).select();
  if (error) return Response.json({ error: error.message }, { status: 500, headers: cors });
  return Response.json({ titles: data, page: payload.page, total_pages: payload.total_pages }, { headers: { ...cors, "Cache-Control": "public, max-age=900" } });
});
