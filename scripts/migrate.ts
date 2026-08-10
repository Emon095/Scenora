import { migrate } from "drizzle-orm/libsql/migrator";
import { db } from "../src/db";

async function main() {
  await migrate(db, { migrationsFolder: "drizzle" });
  console.log("SCENORA database migrations complete.");
}
main().catch((error) => { console.error(error); process.exit(1); });
