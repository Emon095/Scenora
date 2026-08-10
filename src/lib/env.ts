import { z } from "zod";

const schema = z.object({
  NEXT_PUBLIC_SUPABASE_URL: z.string().url(),
  NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY: z.string().min(20),
  TMDB_API_KEY: z.string().optional(),
  AUTH_SECRET: z.string().min(24).optional(),
});
export const env = schema.parse({
  NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL,
  NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY: process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY,
  TMDB_API_KEY: process.env.TMDB_API_KEY,
  AUTH_SECRET: process.env.AUTH_SECRET,
});
