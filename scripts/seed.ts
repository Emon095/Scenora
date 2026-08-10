import { randomUUID } from "node:crypto";
import { db } from "../src/db";
import { genres, profiles, users } from "../src/db/schema";

async function main() {
  const demoId = "demo-shahrier";
  await db.insert(users).values({ id: demoId, email: "demo@scenora.app", username: "shahrieremon", role: "admin" }).onConflictDoNothing();
  await db.insert(profiles).values({ userId: demoId, displayName: "Shahrier Emon", bio: "Movie lover | CSE Student | CTF Player", location: "Dhaka, Bangladesh", verified: true }).onConflictDoNothing();
  for (const [index, name] of ["Action","Adventure","Animation","Comedy","Crime","Documentary","Drama","Fantasy","Horror","Mystery","Romance","Sci-Fi","Thriller","War","Western"].entries()) {
    await db.insert(genres).values({ id: index + 1, name, slug: name.toLowerCase().replaceAll("-", "") }).onConflictDoNothing();
  }
  console.log(`Seeded SCENORA development data (${randomUUID().slice(0, 8)}).`);
}
main().catch((error) => { console.error(error); process.exit(1); });
