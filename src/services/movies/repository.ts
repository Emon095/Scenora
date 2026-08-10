import { createClient } from "@/utils/supabase/client";

export type MovieSummary = { id:number;title:string;original_title?:string;overview:string;poster_path:string|null;backdrop_path:string|null;release_date:string;vote_average:number;vote_count:number;popularity:number;genre_ids:number[] };
export type MoviePage = { page:number;results:MovieSummary[];total_pages:number;total_results:number };
export type MovieDetails = MovieSummary & { internal_id:string;runtime:number|null;genres:{id:number;name:string}[];imdb_id:string|null;community_rating:number|null;community_reviews:number;credits:{cast:{id:number;name:string;character:string;profile_path:string|null}[];crew:{id:number;name:string;job:string}[]};videos:{results:{id:string;key:string;name:string;site:string;type:string;official:boolean}[]};similar:MoviePage;recommendations:MoviePage };
export type DiscoveryAction = "popular"|"top_rated"|"trending"|"now_playing"|"upcoming"|"discover"|"search";
export type DiscoveryRequest = { action:DiscoveryAction;page?:number;query?:string;year?:number;genre?:number;language?:string;country?:string };

async function invoke<T>(body: object):Promise<T>{const{data,error}=await createClient().functions.invoke("tmdb-sync",{body});if(error)throw new Error(error.message);if(data?.error)throw new Error(data.error);return data as T}
export const movieRepository={discover:(request:DiscoveryRequest)=>invoke<MoviePage>(request),details:(movieId:number)=>invoke<MovieDetails>({action:"details",movieId})};
export const posterUrl=(path:string|null,size="w500")=>path?`https://image.tmdb.org/t/p/${size}${path}`:"";
