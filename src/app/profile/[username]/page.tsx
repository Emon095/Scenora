import { people } from "@/data/demo";
import ProfilePageClient from "./ProfilePageClient";

export function generateStaticParams() {
  return [{ username: "shahrieremon" }, ...people.map((person) => ({ username: person.username }))];
}

export default async function ProfilePage({ params }: { params: Promise<{ username: string }> }) {
  const { username } = await params;
  return <ProfilePageClient username={username} />;
}
