# SCENORA Android

SCENORA Android is the Flutter/Dart mobile client for the SCENORA social movie and series review platform. It is developed on the `android-flutter` branch while the existing Next.js application remains intact on `main`.

## Current mobile MVP

The current client includes the five-destination mobile shell from the supplied references: Home, Explore, Create Review, Shoutbox, and Profile. It also includes movie search, genre discovery, movie details, rating and save interactions, social review cards, notifications, settings, local Shoutbox composition, and a responsive dark visual system.

The first build runs in **demo mode by default**. Demo mode uses bundled product fixtures and public poster/avatar URLs so the application can be reviewed without provisioning credentials. The data boundaries are already documented in [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md), and the existing root-level SQL schema remains the backend source of truth.

## Requirements

Install Flutter stable with Dart 3.13 or later, an Android SDK with a configured emulator or physical device, and the usual Android build tools. The repository's current development environment uses Flutter 3.47 stable.

## Run locally

From the repository root:

```bash
cd mobile
flutter pub get
flutter run
```

The app uses remote images when launched normally. If a local review environment has no network access, set `loadRemoteImages = false` in the test or provide a local image adapter through the shared provider in `lib/app.dart`.

## Verification

The expected verification commands are:

```bash
cd mobile
dart format lib test
flutter analyze
flutter test
flutter build apk --debug
```

The current MVP is intentionally backend-ready rather than credential-dependent. Supabase Auth, TMDB discovery through the existing `tmdb-sync` Edge Function, Storage media buckets, and realtime Shoutbox synchronization should be connected through the repository interfaces described in the architecture document. Do not commit Supabase service-role keys, TMDB secrets, or local environment files.

## Branch workflow

Android development is isolated on `android-flutter`. The recommended workflow is to commit mobile work on this branch, push it to GitHub, and merge through a pull request after review. The Next.js web application and its original routes remain available from `main`.
