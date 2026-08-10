"use client";
import Image from "next/image";
import Link from "next/link";
import { Bookmark, ChevronRight, Star } from "lucide-react";
import { useState } from "react";
import type { movies } from "@/data/demo";
type Movie=(typeof movies)[number];
export function MovieList({ items, start=1 }: { items: Movie[]; start?:number }) { return <>{items.map((m,i)=><MovieRow movie={m} rank={start+i} key={m.id}/>)}</> }
function MovieRow({movie:m,rank}:{movie:Movie;rank:number}){const [saved,setSaved]=useState(false);return <article className="card list-card"><div className="num orange">{rank}</div><Link href={`/movie/${m.id}`}><Image src={m.poster} width={300} height={450} alt={m.title}/></Link><div className="list-info"><Link href={`/movie/${m.id}`} style={{color:"inherit",textDecoration:"none"}}><h2>{m.title}</h2></Link><span className="muted">{m.year} &nbsp;•&nbsp; {m.runtime} &nbsp;•&nbsp; {m.genres}</span><div><span className="rating-box"><Star size={19} fill="currentColor"/> {m.external}</span><span className="muted">{(24-rank*2).toFixed(1)}K reviews</span></div><p>{m.overview}</p></div><div><ChevronRight/><button className="icon-btn orange" onClick={()=>setSaved(!saved)} aria-label="Bookmark"><Bookmark fill={saved?"currentColor":"none"}/></button></div></article>}
