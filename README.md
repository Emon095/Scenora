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

## Live TMDB discovery

The browser calls the `tmdb-sync` Supabase Edge Function; the TMDB secret never enters the GitHub Pages bundle. Configure and deploy it with:

```bash
supabase login
supabase link --project-ref fiwcyteletygdkgparoz
supabase secrets set TMDB_API_KEY=your_tmdb_read_access_token
supabase functions deploy tmdb-sync
```

Popular, top-rated, trending, now-playing, upcoming, search, filtered discovery, and full movie details are fetched with pagination and cached into `public.titles`. The SQL migration schedules daily warm-cache refreshes with `pg_cron`; ordinary requests refresh the cache on demand.

## Verification

- `npm run typecheck`
- `npm run build`

Secrets belong only in `.env.local`, which is ignored by Git.
