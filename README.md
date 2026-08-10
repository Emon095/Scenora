# SCENORA

SCENORA is a mobile-first social platform for movie and series lovers. The UI follows the supplied screens in [`design-references`](./design-references).

## Local setup

1. Install packages: `npm install`
2. Create a Supabase project and copy `.env.example` to `.env.local`.
3. Paste `database/scenora.sql` into **Supabase Dashboard → SQL Editor** and run it once.
4. In Supabase Auth URL Configuration, add `http://localhost:3000/**` and `https://emon095.github.io/Scenora/**` as redirect URLs.
5. Start: `npm run dev`.

Open [http://localhost:3000](http://localhost:3000). Supabase stores authentication, profiles, posts, reviews, comments, loves, follows, notifications, media metadata, watchlists, and realtime Shoutbox messages. The public Supabase key is safe to expose because every user-owned table is protected with Row Level Security.

The GitHub Pages build uses the browser Supabase client because GitHub Pages cannot execute Next.js middleware or server routes. `src/utils/supabase/server.ts` is ready for a future Node/Vercel deployment.

## Verification

- `npm run typecheck`
- `npm run build`

Secrets belong only in `.env.local`, which is ignored by Git.
