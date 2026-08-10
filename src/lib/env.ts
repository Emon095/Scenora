import { z } from "zod";

const schema = z.object({ TURSO_DATABASE_URL: z.string().optional(), TURSO_AUTH_TOKEN: z.string().optional(), TMDB_API_KEY: z.string().optional(), AUTH_SECRET: z.string().min(24).optional() });
export const env = schema.parse({ TURSO_DATABASE_URL: process.env.TURSO_DATABASE_URL, TURSO_AUTH_TOKEN: process.env.TURSO_AUTH_TOKEN, TMDB_API_KEY: process.env.TMDB_API_KEY, AUTH_SECRET: process.env.AUTH_SECRET });
