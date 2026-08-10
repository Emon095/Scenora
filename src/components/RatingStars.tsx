import { Star } from "lucide-react";
export function RatingStars({ rating, outOf = 5 }: { rating: number; outOf?: number }) { return <div className="stars" aria-label={`${rating} out of ${outOf}`}>{Array.from({ length: outOf },(_,i)=><Star key={i} size={25} fill={i<rating?"currentColor":"currentColor"} className={i<rating?"":"off"}/>)}</div> }
