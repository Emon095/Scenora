# SCENORA

SCENORA is a mobile-first social platform for movie and series lovers. The UI follows the supplied screens in [`design-references`](./design-references).

## Local setup

1. Install packages: `npm install`
2. Copy `.env.example` to `.env.local` and add Turso, TMDB, and auth values.
3. Generate migrations: `npm run db:generate`
4. Apply migrations: `npm run db:migrate`
5. Add development data: `npm run db:seed`
6. Start: `npm run dev`

Open [http://localhost:3000](http://localhost:3000). Without a TMDB key, the UI uses the clearly separated fixtures in `src/data/demo.ts`; the movie service is ready to fetch live TMDB data once configured.

## Verification

- `npm run typecheck`
- `npm run build`

Secrets belong only in `.env.local`, which is ignored by Git.
