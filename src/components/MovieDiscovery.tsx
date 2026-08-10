"use client";
import Image from "next/image";
import Link from "next/link";
import {FormEvent,useCallback,useEffect,useRef,useState} from "react";
import {Search,Star} from "lucide-react";
import {DiscoveryAction,MovieSummary,movieRepository,posterUrl} from "@/services/movies/repository";

const genreNames:Record<number,string>={28:"Action",12:"Adventure",16:"Animation",35:"Comedy",80:"Crime",99:"Documentary",18:"Drama",10751:"Family",14:"Fantasy",36:"History",27:"Horror",10402:"Music",9648:"Mystery",10749:"Romance",878:"Sci-Fi",53:"Thriller",10752:"War",37:"Western"};

export function MovieDiscovery({action,title,subtitle,filters=false}:{action:DiscoveryAction;title:string;subtitle:string;filters?:boolean}) {
  const [movies,setMovies]=useState<MovieSummary[]>([]),[page,setPage]=useState(1),[totalPages,setTotalPages]=useState(1);
  const [loading,setLoading]=useState(false),[error,setError]=useState(""),[query,setQuery]=useState("");
  const [year,setYear]=useState<number|undefined>(),[genre,setGenre]=useState<number|undefined>(),[language,setLanguage]=useState(""),[country,setCountry]=useState("");
  const sentinel=useRef<HTMLDivElement>(null),loadingRef=useRef(false);
  const load=useCallback(async(nextPage:number,reset=false)=>{
    if(loadingRef.current||(action==="search"&&!query.trim())) return;
    loadingRef.current=true;setLoading(true);setError("");
    try {
      const data=await movieRepository.discover({action:query.trim()?"search":action,page:nextPage,query:query.trim()||undefined,year,genre,language:language||undefined,country:country||undefined});
      setMovies(current=>reset?data.results:[...current,...data.results.filter(movie=>!current.some(item=>item.id===movie.id))]);setPage(data.page);setTotalPages(Math.min(data.total_pages,500));
    } catch {setError("The movie service is temporarily unavailable. Please try again later.")}
    finally {loadingRef.current=false;setLoading(false)}
  },[action,country,genre,language,query,year]);
  useEffect(()=>{setMovies([]);setPage(1);if(action==="search"&&!query.trim()){setLoading(false);return}void load(1,true)},[action,year,genre,language,country,load,query]);
  useEffect(()=>{const node=sentinel.current;if(!node)return;const observer=new IntersectionObserver(entries=>{if(entries[0].isIntersecting&&!loading&&page<totalPages)void load(page+1)},{rootMargin:"500px"});observer.observe(node);return()=>observer.disconnect()},[load,loading,page,totalPages]);
  function search(event:FormEvent){event.preventDefault();setMovies([]);setPage(1);if(query.trim())void load(1,true)}
  return <><h1 className="page-title">{title}</h1><p className="subtitle">{subtitle}</p>
    <form className="card" onSubmit={search} style={{display:"flex",padding:8,gap:8}}><input className="field" value={query} onChange={event=>setQuery(event.target.value)} placeholder="Search movies by title"/><button className="gradient-btn" aria-label="Search"><Search/></button></form>
    {filters&&<div className="tabs" style={{marginTop:15}}><select className="pill" value={year??""} onChange={event=>setYear(event.target.value?Number(event.target.value):undefined)}><option value="">All Years</option>{Array.from({length:130},(_,index)=>new Date().getFullYear()+1-index).map(value=><option value={value} key={value}>{value}</option>)}</select><select className="pill" value={genre??""} onChange={event=>setGenre(event.target.value?Number(event.target.value):undefined)}><option value="">All Genres</option>{Object.entries(genreNames).map(([id,name])=><option value={id} key={id}>{name}</option>)}</select><select className="pill" value={language} onChange={event=>setLanguage(event.target.value)}><option value="">All Languages</option><option value="bn">Bangla</option><option value="en">English</option><option value="hi">Hindi</option><option value="ko">Korean</option><option value="ja">Japanese</option><option value="es">Spanish</option><option value="fr">French</option></select><select className="pill" value={country} onChange={event=>setCountry(event.target.value)}><option value="">All Countries</option><option value="BD">Bangladesh</option><option value="IN">India</option><option value="US">USA</option><option value="KR">South Korea</option><option value="JP">Japan</option><option value="GB">UK</option></select></div>}
    {error&&<div className="card form-card" style={{color:"#ff5c5c"}}>{error} <button className="pill" onClick={()=>void load(page||1,!movies.length)}>Retry</button></div>}
    {action==="search"&&!query.trim()&&!loading&&<div className="card form-card muted">Enter a movie title to start searching.</div>}
    <div className="movie-grid">{movies.map(movie=><Link className="movie-api-card card" href={`/movie/details/?id=${movie.id}`} key={movie.id}>{movie.poster_path?<Image src={posterUrl(movie.poster_path)} width={342} height={513} alt={movie.title}/>:<div className="poster-placeholder">No poster</div>}<div className="movie-card-info"><h3>{movie.title}</h3><span className="muted">{movie.release_date?.slice(0,4)||"TBA"}</span><span className="orange"><Star size={16} fill="currentColor"/> {movie.vote_average?.toFixed(1)??"—"}/10</span><small className="muted">{movie.vote_count?.toLocaleString()??0} votes</small><small>{movie.genre_ids?.slice(0,2).map(id=>genreNames[id]).filter(Boolean).join(", ")}</small></div></Link>)}</div>
    {loading&&<div className="movie-grid">{Array.from({length:6},(_,index)=><div className="card movie-skeleton" key={index}/>)}</div>}<div ref={sentinel} style={{height:10}}/>{!loading&&movies.length>0&&page>=totalPages&&<p className="muted" style={{textAlign:"center"}}>You’ve reached the end of these results.</p>}
  </>;
}
