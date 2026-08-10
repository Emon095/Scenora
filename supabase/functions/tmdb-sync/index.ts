import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const cors = { "Access-Control-Allow-Origin": "*", "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type" };
const tmdbBase = "https://api.themoviedb.org/3";

type RequestBody = { action?:string;page?:number;query?:string;year?:number;genre?:number;language?:string;country?:string;movieId?:number };
type TmdbMovie = { id:number;title:string;original_title?:string;overview?:string;poster_path?:string|null;backdrop_path?:string|null;release_date?:string;vote_average?:number;vote_count?:number;popularity?:number;genre_ids?:number[];genres?:{id:number;name:string}[];runtime?:number;imdb_id?:string;videos?:unknown;credits?:unknown;similar?:unknown;recommendations?:unknown;release_dates?:unknown };

function movieRow(movie: TmdbMovie) {
  return { tmdb_id:movie.id,imdb_id:movie.imdb_id??null,type:"movie",title:movie.title,original_title:movie.original_title??movie.title,overview:movie.overview??null,poster_path:movie.poster_path??null,backdrop_path:movie.backdrop_path??null,release_date:movie.release_date||null,runtime:movie.runtime??null,external_rating:movie.vote_average??null,popularity:movie.popularity??null,updated_at:new Date().toISOString() };
}

Deno.serve(async (request: Request) => {
  if (request.method === "OPTIONS") return new Response("ok", { headers: cors });
  try {
    const tmdbKey = Deno.env.get("TMDB_API_KEY");
    if (!tmdbKey) return Response.json({ error:"TMDB_API_KEY is not configured in Supabase Edge Function secrets." }, { status:503,headers:cors });
    const body = await request.json().catch(() => ({})) as RequestBody;
    const action = body.action ?? "popular";
    const page = Math.min(500, Math.max(1, Number(body.page) || 1));
    const params = new URLSearchParams({ language:"en-US",include_adult:"false" });
    let path: string;

    if (action === "details") {
      if (!body.movieId) return Response.json({ error:"movieId is required" }, { status:400,headers:cors });
      path = `/movie/${body.movieId}`;
      params.set("append_to_response", "credits,videos,similar,recommendations,release_dates");
    } else if (action === "search") {
      if (!body.query?.trim()) return Response.json({ results:[],page:1,total_pages:0,total_results:0 }, { headers:cors });
      path = "/search/movie"; params.set("query",body.query.trim()); params.set("page",String(page));
    } else if (action === "trending") {
      path = "/trending/movie/day"; params.set("page",String(page));
    } else if (action === "discover") {
      path = "/discover/movie"; params.set("page",String(page)); params.set("sort_by","popularity.desc"); params.set("vote_count.gte","10");
      if (body.year) params.set("primary_release_year",String(body.year));
      if (body.genre) params.set("with_genres",String(body.genre));
      if (body.language) params.set("with_original_language",body.language);
      if (body.country) params.set("with_origin_country",body.country);
    } else {
      const lists:Record<string,string> = { popular:"popular",top_rated:"top_rated",now_playing:"now_playing",upcoming:"upcoming" };
      path = `/movie/${lists[action] ?? "popular"}`; params.set("page",String(page));
    }

    const response = await fetch(`${tmdbBase}${path}?${params}`, { headers:{ Authorization:`Bearer ${tmdbKey}`,accept:"application/json" } });
    if (!response.ok) return Response.json({ error:`TMDB request failed (${response.status})`,details:await response.text() }, { status:502,headers:cors });
    const payload = await response.json();
    const admin = createClient(Deno.env.get("SUPABASE_URL")!,Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);

    if (action === "details") {
      const movie = payload as TmdbMovie;
      const { data:cached,error } = await admin.from("titles").upsert(movieRow(movie),{onConflict:"tmdb_id,type"}).select("id").single();
      if (error) throw error;
      const { data:community } = await admin.from("reviews").select("rating").eq("title_id",cached.id);
      const ratings=(community??[]).map((item:{rating:number})=>item.rating);
      return Response.json({ ...movie,internal_id:cached.id,community_rating:ratings.length?ratings.reduce((sum:number,value:number)=>sum+value,0)/ratings.length:null,community_reviews:ratings.length }, { headers:{...cors,"Cache-Control":"public, max-age=3600, stale-while-revalidate=86400"} });
    }

    const movies=(payload.results??[]) as TmdbMovie[];
    if (movies.length) {
      const { error }=await admin.from("titles").upsert(movies.map(movieRow),{onConflict:"tmdb_id,type"});
      if(error)throw error;
    }
    return Response.json(payload,{headers:{...cors,"Cache-Control":"public, max-age=900, stale-while-revalidate=86400"}});
  } catch (error) {
    return Response.json({ error:error instanceof Error?error.message:"Unknown server error" },{status:500,headers:cors});
  }
});
