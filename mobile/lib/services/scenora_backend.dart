import '../app.dart';

enum BackendMode { demo, supabase }

class ScenoraConfig {
  const ScenoraConfig({
    required this.mode,
    this.supabaseUrl,
    this.supabasePublishableKey,
    this.tmdbFunctionUrl,
  });

  final BackendMode mode;
  final String? supabaseUrl;
  final String? supabasePublishableKey;
  final String? tmdbFunctionUrl;

  factory ScenoraConfig.fromEnvironment() {
    const supabaseUrl = String.fromEnvironment('SCENORA_SUPABASE_URL');
    const supabaseKey = String.fromEnvironment(
      'SCENORA_SUPABASE_PUBLISHABLE_KEY',
    );
    const tmdbFunctionUrl = String.fromEnvironment('SCENORA_TMDB_FUNCTION_URL');
    final configured = supabaseUrl.isNotEmpty && supabaseKey.isNotEmpty;

    return ScenoraConfig(
      mode: configured ? BackendMode.supabase : BackendMode.demo,
      supabaseUrl: configured ? supabaseUrl : null,
      supabasePublishableKey: configured ? supabaseKey : null,
      tmdbFunctionUrl: tmdbFunctionUrl.isEmpty ? null : tmdbFunctionUrl,
    );
  }
}

abstract interface class ScenoraBackend {
  BackendMode get mode;

  Future<List<Movie>> discover({String? query});

  Future<void> toggleBookmark({required String title, required bool saved});

  Future<void> publishReview({
    required String title,
    required int rating,
    required String body,
  });

  Stream<ChatMessage> get shoutboxMessages;

  Future<void> sendShoutboxMessage(String body);
}

class DemoScenoraBackend implements ScenoraBackend {
  @override
  BackendMode get mode => BackendMode.demo;

  @override
  Future<List<Movie>> discover({String? query}) async {
    final normalized = query?.trim().toLowerCase() ?? '';
    if (normalized.isEmpty) return movies;
    return movies
        .where((movie) => movie.title.toLowerCase().contains(normalized))
        .toList();
  }

  @override
  Future<void> toggleBookmark({
    required String title,
    required bool saved,
  }) async {}

  @override
  Future<void> publishReview({
    required String title,
    required int rating,
    required String body,
  }) async {}

  @override
  Stream<ChatMessage> get shoutboxMessages => const Stream<ChatMessage>.empty();

  @override
  Future<void> sendShoutboxMessage(String body) async {}
}

class SupabaseScenoraBackend implements ScenoraBackend {
  SupabaseScenoraBackend(this.config);

  final ScenoraConfig config;

  @override
  BackendMode get mode => BackendMode.supabase;

  @override
  Future<List<Movie>> discover({String? query}) {
    return Future.error(
      UnsupportedError(
        'Connect the Supabase tmdb-sync Edge Function before enabling remote discovery.',
      ),
    );
  }

  @override
  Future<void> toggleBookmark({required String title, required bool saved}) {
    return Future.error(
      UnsupportedError(
        'Connect saved_movies through the Supabase repository adapter.',
      ),
    );
  }

  @override
  Future<void> publishReview({
    required String title,
    required int rating,
    required String body,
  }) {
    return Future.error(
      UnsupportedError(
        'Connect posts and reviews through the Supabase repository adapter.',
      ),
    );
  }

  @override
  Stream<ChatMessage> get shoutboxMessages => const Stream<ChatMessage>.empty();

  @override
  Future<void> sendShoutboxMessage(String body) {
    return Future.error(
      UnsupportedError(
        'Connect shoutbox_messages and realtime before enabling remote chat.',
      ),
    );
  }
}

class ScenoraRepository {
  ScenoraRepository({ScenoraBackend? backend})
    : backend = backend ?? DemoScenoraBackend();

  final ScenoraBackend backend;

  static ScenoraRepository fromEnvironment() {
    final config = ScenoraConfig.fromEnvironment();
    return ScenoraRepository(
      backend: config.mode == BackendMode.demo
          ? DemoScenoraBackend()
          : SupabaseScenoraBackend(config),
    );
  }

  Future<List<Movie>> searchMovies(String query) =>
      backend.discover(query: query);

  Future<void> saveMovie(Movie movie, bool saved) =>
      backend.toggleBookmark(title: movie.title, saved: saved);

  Future<void> publishReview(String title, int rating, String body) =>
      backend.publishReview(title: title, rating: rating, body: body);
}
