import { Shell } from "@/components/Shell";import { MovieDiscovery } from "@/components/MovieDiscovery";
export default function Discover(){return <Shell back><MovieDiscovery action="discover" title="Discover Movies" subtitle="Browse by year, genre, language, or country" filters/></Shell>}
