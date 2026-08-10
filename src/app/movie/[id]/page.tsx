import { movies } from "@/data/demo";
import MoviePageClient from "./MoviePageClient";

export function generateStaticParams() {
  return movies.map((movie) => ({ id: movie.id }));
}

export default async function MoviePage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  return <MoviePageClient id={id} />;
}
