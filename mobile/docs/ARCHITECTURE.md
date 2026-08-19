# SCENORA Flutter Android Architecture

## Purpose

The Flutter client is the native Android application for SCENORA, a social movie and series review platform. It will preserve the existing web product's backend contracts while providing a mobile-first experience based on the supplied reference screens.

The implementation is intentionally layered. Presentation code should not call Supabase or TMDB directly. Screens consume state and actions from feature controllers, controllers depend on repository interfaces, and repository implementations can switch between bundled demo data and remote services without changing the UI.

## Product boundaries

The first Android release focuses on the core loop:

> Discover → Open a title → Save or rate it → Write a review → Share the opinion → Discuss with the community.

The initial client includes Home, Explore, Create Review, Shoutbox, Profile, Notifications, Settings, Movie Details, search, genre discovery, review cards, bookmarking state, and polished navigation. Authentication, Supabase persistence, TMDB requests, media uploads, voice messages, and realtime events are exposed as backend-ready interfaces and can be enabled through environment configuration.

## Layered architecture

| Layer | Flutter responsibility | Scenora examples |
|---|---|---|
| Presentation | Widgets, navigation, theme, responsive layouts, local interaction state | Home feed, Explore grid, Movie Details, Shoutbox composer |
| Feature state | Screen-facing controllers and immutable view state | HomeController, ExploreController, MovieDetailsController, ShoutboxController |
| Domain models | Backend-neutral typed entities | Movie, ReviewPost, Person, Genre, ChatMessage, UserProfile |
| Repositories | Stable interfaces for data access and mutations | MovieRepository, SocialRepository, ProfileRepository, ShoutboxRepository |
| Services | External integrations and platform adapters | SupabaseService, TmdbService, MediaService, LocalStore |
| Data sources | Demo fixtures, Supabase queries, TMDB/Edge Function calls | DemoCatalog, Supabase REST/realtime, `tmdb-sync` function |

## Suggested directory structure

```text
mobile/
├── android/                 # Generated Android host project
├── assets/
│   └── images/              # Optional local branding and fixtures
├── docs/
│   └── ARCHITECTURE.md
├── lib/
│   ├── main.dart            # Application entry point
│   ├── app.dart             # MaterialApp, routing, theme, shell
│   ├── core/
│   │   ├── config/          # Compile-time environment and feature flags
│   │   ├── theme/           # Colors, typography, spacing, radii
│   │   ├── navigation/      # Tab shell and route definitions
│   │   └── widgets/         # Shared UI primitives
│   ├── models/               # Immutable product entities
│   ├── data/
│   │   ├── demo/             # Bundled demo catalog and social fixtures
│   │   └── remote/           # DTOs/adapters for Supabase and TMDB
│   ├── repositories/         # Interfaces plus demo/remote implementations
│   ├── services/             # Supabase, TMDB, storage, media abstractions
│   ├── state/                # App/session state and feature controllers
│   ├── shared/               # Formatters, constants, extensions
│   └── screens/
│       ├── home/
│       ├── explore/
│       ├── create_review/
│       ├── movie_details/
│       ├── shoutbox/
│       ├── profile/
│       ├── notifications/
│       └── settings/
├── test/                    # Unit and widget tests
├── pubspec.yaml
└── README.md
```

## Navigation model

The app uses a five-destination shell matching the reference designs: Home, Explore, Create, Shoutbox, and Profile. Create is represented as a prominent center action rather than a normal tab. Secondary routes are pushed above the shell: Movie Details, Search, Notifications, Settings, Login, and full discovery lists.

The shell owns the persistent bottom navigation. Feature screens remain independent of the shell so a movie detail route can be opened from Home, Explore, search, or a review card without duplicating navigation logic.

## State strategy

The first implementation uses small, explicit controllers backed by `ChangeNotifier` and immutable model objects. This avoids introducing a state-management dependency before the domain boundaries are stable. A later release can migrate controllers to Riverpod or another preferred solution without changing the repositories or models.

The app starts in demo mode when Supabase configuration is absent. When remote configuration is present, the same repository interfaces can use Supabase and the TMDB Edge Function. UI actions such as love, follow, save, comment, and send message update the local state optimistically and then delegate persistence to the remote repository when enabled.

## Backend mapping

| Flutter contract | Existing backend source |
|---|---|
| Session and profile | Supabase Auth and `profiles` |
| Movie catalog | `titles`, `genres`, `movie_genres`, `movie_countries`, `movie_languages`; TMDB through `tmdb-sync` |
| Home review feed | `posts`, `post_images`, `reviews`, `post_likes`, `post_comments`, `post_shares` |
| Follow and profile activity | `follows`, `profiles`, `notifications` |
| Save/watchlist | `saved_movies`, `watchlist`, `user_movie_interactions` |
| Shoutbox | `shoutbox_messages`, `shoutbox_reactions`, Supabase realtime |
| Media | Supabase Storage buckets `avatars`, `post-media`, and `shoutbox-media` |

The Flutter application must never embed a TMDB secret. The intended remote path is the existing Supabase Edge Function, while a public Supabase publishable key may be supplied through build-time configuration. Secrets belong outside source control.

## Visual system

The reference screens establish a near-black foundation, high-contrast white typography, orange action highlights, subdued charcoal cards, thin borders, large rounded corners, and cinematic poster imagery. The Flutter theme should centralize these decisions:

| Token | Initial intent |
|---|---|
| Background | Near-black, approximately `#050607` |
| Surface | Charcoal-black cards, approximately `#111315` |
| Primary | Scenora orange, approximately `#FF6B18` |
| Secondary accent | Warm gold for ratings, approximately `#FFC247` |
| Positive status | Green online indicator |
| Text | White primary, muted gray secondary |
| Shape | 16–24 px cards, pill controls, circular avatars |

The implementation should use `SafeArea`, adaptive spacing, horizontal poster carousels, lazy lists, and accessible labels. It should remain usable on small Android phones while scaling gracefully to larger screens.

## Delivery slices

1. Establish the shell, theme, demo models, and route structure.
2. Build Home and Explore around the reference layouts.
3. Add Movie Details with save, trailer, rating, cast, and similar-title sections.
4. Add Create Review, Profile, Notifications, and Settings.
5. Add Shoutbox with local text/image/voice-style message presentation and backend-ready repository interfaces.
6. Add remote configuration, documentation, tests, and Android verification.

## Quality expectations

Every feature should be implemented with typed models, reusable widgets, clear loading/empty/error states, and no committed secrets. The Android branch should remain independently runnable in demo mode, so reviewers can assess the product without first provisioning Supabase or TMDB.
