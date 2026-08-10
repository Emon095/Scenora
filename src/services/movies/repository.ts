import { createClient } from "@/utils/supabase/client";

export type MovieSummary = { id:number;title:string;original_title?:string;overview:string;poster_path:string|null;backdrop_path:string|null;release_date:string;vote_average:number;vote_count:number;popularity:number;genre_ids:number[] };
export type MoviePage = { page:number;results:MovieSummary[];total_pages:number;total_results:number };
export type MovieDetails = MovieSummary & { internal_id:string;runtime:number|null;genres:{id:number;name:string}[];imdb_id:string|null;community_rating:number|null;community_reviews:number;credits:{cast:{id:number;name:string;character:string;profile_path:string|null}[];crew:{id:number;name:string;job:string}[]};videos:{results:{id:string;key:string;name:string;site:string;type:string;official:boolean}[]};similar:MoviePage;recommendations:MoviePage };
export type DiscoveryAction = "popular"|"top_rated"|"trending"|"now_playing"|"upcoming"|"discover"|"search";
export type DiscoveryRequest = { action:DiscoveryAction;page?:number;query?:string;year?:number;genre?:number;language?:string;country?:string };

type CachedMovie = { tmdb_id:number|null;title:string;original_title:string|null;overview:string|null;poster_path:string|null;backdrop_path:string|null;release_date:string|null;external_rating:number|null;vote_count:number|null;popularity:number|null };

const emptyPage = (page=1):MoviePage => ({page,results:[],total_pages:1,total_results:0});

function mapCachedMovie(movie:CachedMovie):MovieSummary {
  return {id:movie.tmdb_id??0,title:movie.title,original_title:movie.original_title??undefined,overview:movie.overview??"",poster_path:movie.poster_path,backdrop_path:movie.backdrop_path,release_date:movie.release_date??"",vote_average:Number(movie.external_rating??0),vote_count:Number(movie.vote_count??0),popularity:Number(movie.popularity??0),genre_ids:[]};
}

async function cachedDiscover(request:DiscoveryRequest):Promise<MoviePage> {
  const page=Math.max(1,request.page??1);
  const pageSize=20;
  const from=(page-1)*pageSize;
  let query=createClient().from("titles").select("tmdb_id,title,original_title,overview,poster_path,backdrop_path,release_date,external_rating,vote_count,popularity",{count:"exact"}).eq("type","movie").not("tmdb_id","is",null);
  if(request.query?.trim()) query=query.ilike("title",`%${request.query.trim()}%`);
  if(request.year) query=query.gte("release_date",`${request.year}-01-01`).lte("release_date",`${request.year}-12-31`);
  if(request.action==="top_rated") query=query.order("external_rating",{ascending:false,nullsFirst:false});
  else if(request.action==="upcoming") query=query.order("release_date",{ascending:true,nullsFirst:false});
  else query=query.order("popularity",{ascending:false,nullsFirst:false});
  const {data,error,count}=await query.range(from,from+pageSize-1);
  if(error) return emptyPage(page);
  const total=count??data?.length??0;
  return {page,results:((data??[]) as CachedMovie[]).map(mapCachedMovie),total_results:total,total_pages:Math.max(1,Math.ceil(total/pageSize))};
}

async function invoke<T>(body:object):Promise<T> {
  const {data,error}=await createClient().functions.invoke("tmdb-sync",{body});
  if(error) throw error;
  if(data?.error) throw new Error(data.error);
  return data as T;
}

export const movieRepository={
  async discover(request:DiscoveryRequest){
    try{return await invoke<MoviePage>(request)}catch{return cachedDiscover(request)}
  },
  async details(movieId:number){
    try{return await invoke<MovieDetails>({action:"details",movieId})}catch{throw new Error("Movie details are temporarily unavailable. Please try again later.")}
  }
};
export const posterUrl=(path:string|null,size="w500")=>path?`https://image.tmdb.org/t/p/${size}${path}`:"";
