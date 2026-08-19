import 'package:flutter/material.dart';

bool loadRemoteImages = true;

ImageProvider<Object> scenoraImageProvider(String url) => loadRemoteImages
    ? NetworkImage(url)
    : const AssetImage('assets/images/placeholder.png');

class ScenoraColors {
  static const background = Color(0xFF050607);
  static const surface = Color(0xFF111315);
  static const surfaceSoft = Color(0xFF191B1E);
  static const border = Color(0xFF2B2E32);
  static const orange = Color(0xFFFF6818);
  static const orangeDark = Color(0xFFD9410C);
  static const gold = Color(0xFFFFC247);
  static const muted = Color(0xFF9A9CA2);
  static const green = Color(0xFF64D55B);
  static const blue = Color(0xFF72C8FF);
}

class Movie {
  const Movie({
    required this.title,
    required this.poster,
    required this.backdrop,
    required this.rating,
    required this.year,
    required this.genres,
    required this.overview,
    this.runtime = '2h 29m',
    this.director = 'Christopher Nolan',
  });

  final String title;
  final String poster;
  final String backdrop;
  final double rating;
  final int year;
  final List<String> genres;
  final String overview;
  final String runtime;
  final String director;
}

class ReviewPost {
  const ReviewPost({
    required this.user,
    required this.avatar,
    required this.movie,
    required this.body,
    required this.rating,
    required this.time,
    required this.tags,
    required this.images,
    required this.likes,
    required this.comments,
  });

  final String user;
  final String avatar;
  final Movie movie;
  final String body;
  final int rating;
  final String time;
  final List<String> tags;
  final List<String> images;
  final int likes;
  final int comments;
}

class ChatMessage {
  const ChatMessage({
    required this.user,
    required this.avatar,
    required this.time,
    required this.body,
    this.image,
    this.voiceDuration,
    this.reactions = 0,
    this.userColor = ScenoraColors.orange,
  });

  final String user;
  final String avatar;
  final String time;
  final String body;
  final String? image;
  final String? voiceDuration;
  final int reactions;
  final Color userColor;
}

const movies = <Movie>[
  Movie(
    title: 'Oppenheimer',
    poster: 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
    backdrop:
        'https://image.tmdb.org/t/p/w1280/3f92DMBTFqr3wgDtE5nGVqV9q3o.jpg',
    rating: 4.6,
    year: 2023,
    genres: ['Drama', 'History', 'Thriller'],
    overview: 'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.',
    runtime: '3h 1m',
  ),
  Movie(
    title: 'Interstellar',
    poster: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    backdrop:
        'https://image.tmdb.org/t/p/w1280/xJHokMbljvjADYdit5fK5VQsXEG.jpg',
    rating: 4.5,
    year: 2014,
    genres: ['Sci-Fi', 'Drama', 'Adventure'],
    overview: 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
  ),
  Movie(
    title: 'The Dark Knight',
    poster: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    backdrop:
        'https://image.tmdb.org/t/p/w1280/hkBaDkMWbLaf8B1lsWsKX7Ew3Xq.jpg',
    rating: 4.4,
    year: 2008,
    genres: ['Action', 'Crime', 'Drama'],
    overview: 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests.',
    runtime: '2h 32m',
  ),
  Movie(
    title: 'Inception',
    poster: 'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg',
    backdrop:
        'https://image.tmdb.org/t/p/w1280/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg',
    rating: 4.3,
    year: 2010,
    genres: ['Action', 'Sci-Fi', 'Thriller'],
    overview: 'A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.',
  ),
  Movie(
    title: 'Dune: Part Two',
    poster: 'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
    backdrop:
        'https://image.tmdb.org/t/p/w1280/3Wzl6mN5d5r2KJkZV7L5s4M1R0E.jpg',
    rating: 4.6,
    year: 2024,
    genres: ['Sci-Fi', 'Adventure'],
    overview: 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    runtime: '2h 46m',
  ),
];

const genreNames = <String>[
  'Action',
  'Adventure',
  'Animation',
  'Comedy',
  'Crime',
  'Drama',
  'Fantasy',
  'Horror',
  'Mystery',
  'Romance',
  'Sci-Fi',
  'Thriller',
];

final demoReviews = <ReviewPost>[
  ReviewPost(
    user: 'Shahrier Emon',
    avatar: 'https://i.pravatar.cc/150?img=68',
    movie: movies[1],
    body: 'A masterpiece that makes you question your entire existence. Nolan\'s direction, the music, everything was beyond perfect.',
    rating: 4,
    time: '2h ago',
    tags: ['SciFi', 'Masterpiece', 'MindBlowing'],
    images: [
      'https://image.tmdb.org/t/p/w500/2Qq8IwHu4KIwUM8i2hYlY7G8X1p.jpg',
      'https://image.tmdb.org/t/p/w500/xJHokMbljvjADYdit5fK5VQsXEG.jpg',
      'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    ],
    likes: 189,
    comments: 32,
  ),
  ReviewPost(
    user: 'Tania Rahman',
    avatar: 'https://i.pravatar.cc/150?img=47',
    movie: movies[4],
    body: 'Denis Villeneuve did it again. The visuals, the score, the story—absolutely breathtaking.',
    rating: 5,
    time: '5h ago',
    tags: ['Epic', 'MustWatch', 'Cinematic'],
    images: [],
    likes: 142,
    comments: 21,
  ),
];

final demoMessages = <ChatMessage>[
  ChatMessage(
    user: 'Naveed Ahmed',
    avatar: 'https://i.pravatar.cc/150?img=11',
    time: '9:41 PM',
    body: 'Just finished Interstellar again! Always gives me chills 🚀',
    reactions: 12,
  ),
  ChatMessage(
    user: 'Tania Rahman',
    avatar: 'https://i.pravatar.cc/150?img=47',
    time: '9:41 PM',
    body: 'Same here! That soundtrack is everything.',
    reactions: 7,
    userColor: const Color(0xFFB78BFF),
  ),
  ChatMessage(
    user: 'Sami Ul Haque',
    avatar: 'https://i.pravatar.cc/150?img=12',
    time: '9:42 PM',
    body: 'Look at this shot 🤩',
    image: 'https://image.tmdb.org/t/p/w780/xJHokMbljvjADYdit5fK5VQsXEG.jpg',
    reactions: 15,
    userColor: const Color(0xFFE86D9E),
  ),
  ChatMessage(
    user: 'Shahrier Emon',
    avatar: 'https://i.pravatar.cc/150?img=68',
    time: '9:42 PM',
    body: 'This movie is a masterpiece. No doubt.',
    reactions: 9,
    userColor: ScenoraColors.blue,
  ),
  ChatMessage(
    user: 'Farhana Islam',
    avatar: 'https://i.pravatar.cc/150?img=32',
    time: '9:43 PM',
    body: '',
    voiceDuration: '0:18',
    reactions: 10,
    userColor: const Color(0xFF62D2C7),
  ),
  ChatMessage(
    user: 'Movie Buffs',
    avatar: 'https://i.pravatar.cc/150?img=5',
    time: '9:44 PM',
    body: 'What\'s your all-time favorite movie?',
    reactions: 8,
    userColor: ScenoraColors.blue,
  ),
];

class ScenoraApp extends StatelessWidget {
  const ScenoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ScenoraColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ScenoraColors.orange,
        brightness: Brightness.dark,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      dividerColor: ScenoraColors.border,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ScenoraColors.surface,
        hintStyle: const TextStyle(color: ScenoraColors.muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ScenoraColors.orange),
        ),
      ),
    );
    return MaterialApp(
      title: 'SCENORA',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;
  final savedMovies = <String>{};
  final lovedPosts = <int>{};

  void openMovie(Movie movie) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => MovieDetailsScreen(
          movie: movie,
          saved: savedMovies.contains(movie.title),
          onSave: () {
            setState(() {
              if (savedMovies.contains(movie.title)) {
                savedMovies.remove(movie.title);
              } else {
                savedMovies.add(movie.title);
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(
        onMovieTap: openMovie,
        onExplore: () => setState(() => index = 1),
        lovedPosts: lovedPosts,
        onLove: (postIndex) => setState(() {
          if (lovedPosts.contains(postIndex)) {
            lovedPosts.remove(postIndex);
          } else {
            lovedPosts.add(postIndex);
          }
        }),
      ),
      ExploreScreen(onMovieTap: openMovie),
      CreateReviewScreen(onMovieTap: openMovie),
      const ShoutboxScreen(),
      ProfileScreen(savedMovies: savedMovies, onMovieTap: openMovie),
    ];

    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: ScenoraBottomBar(
        index: index,
        onChanged: (value) => setState(() => index = value),
      ),
    );
  }
}

class ScenoraBottomBar extends StatelessWidget {
  const ScenoraBottomBar({
    required this.index,
    required this.onChanged,
    super.key,
  });
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: ScenoraColors.surface,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: ScenoraColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Home',
              active: index == 0,
              onTap: () => onChanged(0),
            ),
            NavItem(
              icon: Icons.explore_outlined,
              activeIcon: Icons.explore,
              label: 'Explore',
              active: index == 1,
              onTap: () => onChanged(1),
            ),
            GestureDetector(
              onTap: () => onChanged(2),
              child: Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [ScenoraColors.orange, ScenoraColors.orangeDark],
                  ),
                ),
                child: const Icon(Icons.add, size: 34),
              ),
            ),
            NavItem(
              icon: Icons.chat_bubble_outline,
              activeIcon: Icons.chat_bubble,
              label: 'Shoutbox',
              active: index == 3,
              onTap: () => onChanged(3),
              dot: true,
            ),
            NavItem(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: 'Profile',
              active: index == 4,
              onTap: () => onChanged(4),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.active,
    required this.onTap,
    this.dot = false,
    super.key,
  });
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  final bool dot;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 62,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Icon(
                  active ? activeIcon : icon,
                  color: active ? ScenoraColors.orange : Colors.white70,
                ),
                if (dot)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: ScenoraColors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: active ? ScenoraColors.orange : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({this.action, super.key});
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Row(
        children: [
          const Icon(Icons.menu, size: 27),
          const Spacer(),
          const ScenoraLogo(),
          const Spacer(),
          action ?? const Icon(Icons.notifications_none, size: 27),
        ],
      ),
    );
  }
}

class ScenoraLogo extends StatelessWidget {
  const ScenoraLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'SCEN',
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const TextSpan(
            text: 'O',
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w700,
              color: ScenoraColors.orange,
            ),
          ),
          const TextSpan(
            text: 'RA',
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {this.action, this.onTap, super.key});
  final String title;
  final String? action;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          if (action != null)
            TextButton(
              onPressed: onTap,
              child: Text(
                action!,
                style: const TextStyle(color: ScenoraColors.orange),
              ),
            ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.onMovieTap,
    required this.onExplore,
    required this.lovedPosts,
    required this.onLove,
    super.key,
  });
  final ValueChanged<Movie> onMovieTap;
  final VoidCallback onExplore;
  final Set<int> lovedPosts;
  final ValueChanged<int> onLove;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const ScreenHeader(),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 3, 20, 0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Discover. Watch. ',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                TextSpan(
                  text: 'Share.',
                  style: TextStyle(
                    color: ScenoraColors.orange,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const ReviewerRail(),
        const FeedFilters(),
        ...List.generate(
          demoReviews.length,
          (i) => ReviewCard(
            post: demoReviews[i],
            loved: lovedPosts.contains(i),
            onLove: () => onLove(i),
            onMovieTap: () => onMovieTap(demoReviews[i].movie),
          ),
        ),
        SectionTitle('Trending This Week', action: 'See All', onTap: onExplore),
        MovieRail(movies: movies, onTap: onMovieTap),
        const SizedBox(height: 16),
      ],
    );
  }
}

class ReviewerRail extends StatelessWidget {
  const ReviewerRail({super.key});

  @override
  Widget build(BuildContext context) {
    const names = ['Naveed', 'Farhana', 'Sami', 'Tania', 'Mahin'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Top Rated Reviewers', action: 'See All'),
        SizedBox(
          height: 114,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: names.length,
            separatorBuilder: (_, index) => const SizedBox(width: 13),
            itemBuilder: (context, index) => SizedBox(
              width: 75,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 67,
                        height: 67,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: index.isEven
                                ? ScenoraColors.orange
                                : const Color(0xFF9E54E9),
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: scenoraImageProvider(
                              'https://i.pravatar.cc/160?img=${11 + index * 9}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            color: ScenoraColors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    names[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    '★ 4.8',
                    style: TextStyle(color: ScenoraColors.gold, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FeedFilters extends StatelessWidget {
  const FeedFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        children: ['For You', 'Following', 'Trending', 'New Releases']
            .map(
              (label) => Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: label == 'For You'
                      ? ScenoraColors.orangeDark
                      : ScenoraColors.surfaceSoft,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: label == 'For You'
                        ? ScenoraColors.orange
                        : Colors.transparent,
                  ),
                ),
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    required this.post,
    required this.loved,
    required this.onLove,
    required this.onMovieTap,
    super.key,
  });
  final ReviewPost post;
  final bool loved;
  final VoidCallback onLove;
  final VoidCallback onMovieTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      color: ScenoraColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: ScenoraColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: scenoraImageProvider(post.avatar),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.user,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${post.time}  •  Watched ${post.movie.title}',
                        style: const TextStyle(
                          color: ScenoraColors.muted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz),
              ],
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: onMovieTap,
              child: Text(
                post.movie.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                RatingStars(rating: post.rating),
                const SizedBox(width: 9),
                Text(
                  '${post.rating}/5',
                  style: const TextStyle(color: ScenoraColors.muted),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Wrap(
              spacing: 8,
              children: post.tags
                  .map(
                    (tag) => Text(
                      '#$tag',
                      style: const TextStyle(
                        color: ScenoraColors.blue,
                        fontSize: 12,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            Text(
              post.body,
              style: const TextStyle(color: Colors.white70, height: 1.35),
            ),
            if (post.images.isNotEmpty) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 124,
                child: Row(
                  children: post.images
                      .take(3)
                      .map(
                        (url) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: scenoraImageProvider(url),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
            const SizedBox(height: 12),
            const Divider(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: onLove,
                  child: ActionStat(
                    icon: Icons.favorite,
                    label: '${post.likes}',
                    color: loved ? Colors.redAccent : ScenoraColors.orange,
                  ),
                ),
                const ActionStat(
                  icon: Icons.mode_comment_outlined,
                  label: '32',
                ),
                const ActionStat(icon: Icons.reply_outlined, label: '18'),
                const ActionStat(icon: Icons.bookmark_border, label: ''),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class ActionStat extends StatelessWidget {
  const ActionStat({
    required this.icon,
    required this.label,
    this.color,
    super.key,
  });
  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Icon(icon, size: 22, color: color ?? Colors.white70),
        if (label.isNotEmpty) ...[
          const SizedBox(width: 7),
          Text(label, style: TextStyle(color: color ?? Colors.white70)),
        ],
      ],
    ),
  );
}

class RatingStars extends StatelessWidget {
  const RatingStars({required this.rating, super.key});
  final int rating;
  @override
  Widget build(BuildContext context) => Row(
    children: List.generate(
      5,
      (i) => Icon(
        i < rating ? Icons.star : Icons.star_border,
        color: ScenoraColors.gold,
        size: 21,
      ),
    ),
  );
}

class MovieRail extends StatelessWidget {
  const MovieRail({required this.movies, required this.onTap, super.key});
  final List<Movie> movies;
  final ValueChanged<Movie> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (_, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () => onTap(movie),
            child: SizedBox(
              width: 116,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: PosterCard(movie: movie)),
                  const SizedBox(height: 7),
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '★ ${movie.rating}',
                    style: const TextStyle(
                      color: ScenoraColors.gold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PosterCard extends StatelessWidget {
  const PosterCard({required this.movie, this.height, super.key});
  final Movie movie;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ScenoraColors.border),
        image: DecorationImage(
          image: scenoraImageProvider(movie.poster),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.all(7),
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(190),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '★ ${movie.rating}',
            style: const TextStyle(
              color: ScenoraColors.gold,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({required this.onMovieTap, super.key});
  final ValueChanged<Movie> onMovieTap;
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = movies
        .where(
          (movie) => movie.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const ScreenHeader(),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
          child: Text(
            'Explore',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: Text(
            'Discover movies, genres and reviews',
            style: TextStyle(color: ScenoraColors.muted, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 4),
          child: TextField(
            onChanged: (value) => setState(() => query = value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search movies, people, reviews...',
              suffixIcon: Icon(Icons.tune, color: ScenoraColors.orange),
            ),
          ),
        ),
        const SectionTitle('Browse by Genre', action: 'See All'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) =>
                GenreCard(label: genreNames[index], index: index),
          ),
        ),
        const SectionTitle('Trending Movies', action: 'See All'),
        MovieRail(
          movies: filtered.isEmpty ? movies : filtered,
          onTap: widget.onMovieTap,
        ),
        const SectionTitle('Top Reviews This Week', action: 'See All'),
        ReviewCard(
          post: demoReviews[0],
          loved: false,
          onLove: () {},
          onMovieTap: () => widget.onMovieTap(demoReviews[0].movie),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class GenreCard extends StatelessWidget {
  const GenreCard({required this.label, required this.index, super.key});
  final String label;
  final int index;

  @override
  Widget build(BuildContext context) {
    const icons = [
      Icons.local_fire_department,
      Icons.landscape,
      Icons.movie,
      Icons.sentiment_very_satisfied,
      Icons.masks,
      Icons.camera_alt,
      Icons.theater_comedy,
      Icons.auto_awesome,
    ];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: ScenoraColors.border),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1D2328), ScenoraColors.surface],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icons[index], color: Colors.white, size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({
    required this.movie,
    required this.saved,
    required this.onSave,
    super.key,
  });
  final Movie movie;
  final bool saved;
  final VoidCallback onSave;
  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late bool saved = widget.saved;

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    final relatedMovies = movies
        .where((item) => item.title != movie.title)
        .toList();

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 405,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(
                  image: scenoraImageProvider(movie.backdrop),
                  fit: BoxFit.cover,
                  errorBuilder: (_, error, stack) =>
                      Container(color: ScenoraColors.surface),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, ScenoraColors.background],
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() => saved = !saved);
                            widget.onSave();
                          },
                          icon: Icon(
                            saved ? Icons.bookmark : Icons.bookmark_border,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined),
                        ),
                        const Icon(Icons.more_vert),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: ScenoraColors.orange.withAlpha(220),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text(
                          'NOW PLAYING',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        children: [
                          Text(
                            '${movie.year}',
                            style: const TextStyle(color: ScenoraColors.muted),
                          ),
                          Text(
                            '• ${movie.runtime}',
                            style: const TextStyle(color: ScenoraColors.muted),
                          ),
                          ...movie.genres
                              .take(2)
                              .map(
                                (genre) => Chip(
                                  label: Text(
                                    genre,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: Row(
              children: [
                const Icon(Icons.star, color: ScenoraColors.gold, size: 30),
                const SizedBox(width: 8),
                Text(
                  '${movie.rating}',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '  community rating',
                  style: TextStyle(color: ScenoraColors.muted),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: const Text('Trailer'),
                  style: FilledButton.styleFrom(
                    backgroundColor: ScenoraColors.orange,
                  ),
                ),
              ],
            ),
          ),
          DetailSection(
            title: 'Synopsis',
            child: Text(
              movie.overview,
              style: const TextStyle(color: Colors.white70, height: 1.45),
            ),
          ),
          DetailSection(
            title: 'Movie Details',
            child: Row(
              children: [
                Expanded(
                  child: InfoTile(
                    icon: Icons.calendar_month,
                    title: 'Release',
                    value: '${movie.year}',
                  ),
                ),
                Expanded(
                  child: InfoTile(
                    icon: Icons.movie_creation_outlined,
                    title: 'Director',
                    value: movie.director,
                  ),
                ),
                Expanded(
                  child: InfoTile(
                    icon: Icons.language,
                    title: 'Language',
                    value: 'English',
                  ),
                ),
              ],
            ),
          ),
          const SectionTitle('You Might Also Like', action: 'View All'),
          MovieRail(
            movies: relatedMovies,
            onTap: (item) => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => MovieDetailsScreen(
                  movie: item,
                  saved: false,
                  onSave: () {},
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DetailSection extends StatelessWidget {
  const DetailSection({required this.title, required this.child, super.key});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}

class InfoTile extends StatelessWidget {
  const InfoTile({
    required this.icon,
    required this.title,
    required this.value,
    super.key,
  });
  final IconData icon;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
    decoration: BoxDecoration(
      color: ScenoraColors.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ScenoraColors.border),
    ),
    child: Column(
      children: [
        Icon(icon, color: ScenoraColors.orange, size: 22),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(color: ScenoraColors.muted, fontSize: 11),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({required this.onMovieTap, super.key});
  final ValueChanged<Movie> onMovieTap;
  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  int rating = 4;
  final controller = TextEditingController();
  final selectedMovie = movies[1];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          children: [
            const Row(children: [ScenoraLogo(), Spacer(), Icon(Icons.close)]),
            const SizedBox(height: 28),
            const Text(
              'Create a review',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tell the community what you watched.',
              style: TextStyle(color: ScenoraColors.muted, fontSize: 15),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => widget.onMovieTap(selectedMovie),
              child: Row(
                children: [
                  PosterCard(movie: selectedMovie, height: 110),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reviewing',
                          style: TextStyle(color: ScenoraColors.muted),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          selectedMovie.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${selectedMovie.year}  •  ${selectedMovie.genres.first}',
                          style: const TextStyle(color: ScenoraColors.muted),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Change title',
                          style: TextStyle(
                            color: ScenoraColors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your rating',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(
                5,
                (i) => IconButton(
                  onPressed: () => setState(() => rating = i + 1),
                  icon: Icon(
                    i < rating ? Icons.star : Icons.star_border,
                    color: ScenoraColors.gold,
                    size: 34,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: controller,
              minLines: 5,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: 'Write your thoughts...',
                contentPadding: EdgeInsets.all(18),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.image_outlined),
                  label: const Text('Add image'),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.local_offer_outlined),
                  label: const Text('Add tags'),
                ),
              ],
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 52,
              child: FilledButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Review saved to your draft.')),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: ScenoraColors.orange,
                ),
                child: const Text(
                  'Publish review',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShoutboxScreen extends StatefulWidget {
  const ShoutboxScreen({super.key});
  @override
  State<ShoutboxScreen> createState() => _ShoutboxScreenState();
}

class _ShoutboxScreenState extends State<ShoutboxScreen> {
  final controller = TextEditingController();
  final messages = List<ChatMessage>.from(demoMessages);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void send() {
    if (controller.text.trim().isEmpty) return;
    setState(() {
      messages.add(
        ChatMessage(
          user: 'You',
          avatar: 'https://i.pravatar.cc/150?img=68',
          time: 'now',
          body: controller.text.trim(),
          userColor: ScenoraColors.orange,
        ),
      );
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ScreenHeader(),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 4, 20, 16),
              child: Row(
                children: [
                  Text(
                    'Shoutbox',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 10),
                  LivePill(),
                  Spacer(),
                  Icon(Icons.circle, size: 9, color: ScenoraColors.green),
                  SizedBox(width: 6),
                  Text(
                    '342 online',
                    style: TextStyle(color: ScenoraColors.muted),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: messages.length,
                itemBuilder: (context, index) =>
                    ChatBubble(message: messages[index]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 8, 18, 12),
              child: Row(
                children: [
                  Icon(Icons.more_horiz, color: ScenoraColors.muted),
                  SizedBox(width: 8),
                  Text(
                    'Several people are typing...',
                    style: TextStyle(color: ScenoraColors.muted, fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onSubmitted: (_) => send(),
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file, color: Colors.white70),
                  ),
                  IconButton(
                    onPressed: send,
                    icon: const Icon(
                      Icons.send,
                      color: ScenoraColors.orange,
                      size: 29,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LivePill extends StatelessWidget {
  const LivePill({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: ScenoraColors.orange.withAlpha(38),
      borderRadius: BorderRadius.circular(9),
    ),
    child: const Text(
      'LIVE',
      style: TextStyle(
        color: ScenoraColors.orange,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message, super.key});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (message.image != null) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Image(
          image: scenoraImageProvider(message.image!),
          height: 145,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    } else if (message.voiceDuration != null) {
      content = Row(
        children: [
          const Icon(
            Icons.play_circle_fill,
            color: ScenoraColors.orange,
            size: 28,
          ),
          const SizedBox(width: 8),
          ...List.generate(
            18,
            (i) => Container(
              width: 2,
              height: 8.0 + (i % 5) * 4,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            message.voiceDuration!,
            style: const TextStyle(color: ScenoraColors.muted, fontSize: 12),
          ),
        ],
      );
    } else {
      content = Text(
        message.body,
        style: const TextStyle(color: Colors.white, height: 1.3),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: scenoraImageProvider(message.avatar),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      message.user,
                      style: TextStyle(
                        color: message.userColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      message.time,
                      style: const TextStyle(
                        color: ScenoraColors.muted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: ScenoraColors.surface,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: content,
                ),
                if (message.reactions > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ScenoraColors.surfaceSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '❤️ ${message.reactions}',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    required this.savedMovies,
    required this.onMovieTap,
    super.key,
  });
  final Set<String> savedMovies;
  final ValueChanged<Movie> onMovieTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ScreenHeader(
          action: IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
            ),
            icon: const Icon(Icons.settings_outlined),
          ),
        ),
        const SizedBox(height: 18),
        CircleAvatar(
          radius: 46,
          backgroundImage: scenoraImageProvider(
            'https://i.pravatar.cc/200?img=68',
          ),
        ),
        const SizedBox(height: 10),
        const Center(
          child: Text(
            'Shahrier Emon',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
          ),
        ),
        const Center(
          child: Text(
            '@shahrieremon',
            style: TextStyle(color: ScenoraColors.muted),
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Movie lover • Reviewer • Storyteller',
            style: TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 18),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProfileStat('156', 'Reviews'),
            ProfileStat('2.4K', 'Followers'),
            ProfileStat('312', 'Following'),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Edit profile'),
            ),
          ),
        ),
        SectionTitle('Saved Movies', action: '${savedMovies.length} saved'),
        MovieRail(movies: movies, onTap: onMovieTap),
        const SectionTitle('Recent Reviews'),
        ...demoReviews.map(
          (post) => ReviewCard(
            post: post,
            loved: false,
            onLove: () {},
            onMovieTap: () => onMovieTap(post.movie),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class ProfileStat extends StatelessWidget {
  const ProfileStat(this.value, this.label, {super.key});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 3),
      Text(
        label,
        style: const TextStyle(color: ScenoraColors.muted, fontSize: 12),
      ),
    ],
  );
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Notifications',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        NotificationTile(
          icon: Icons.favorite,
          color: Colors.redAccent,
          title: 'Tania Rahman loved your review',
          subtitle: 'Dune: Part Two · 12 min ago',
        ),
        NotificationTile(
          icon: Icons.person_add,
          color: ScenoraColors.blue,
          title: 'Naveed Ahmed started following you',
          subtitle: '1 hour ago',
        ),
        NotificationTile(
          icon: Icons.mode_comment,
          color: ScenoraColors.orange,
          title: 'Sami commented on your review',
          subtitle: 'Interstellar · 2 hours ago',
        ),
        NotificationTile(
          icon: Icons.star,
          color: ScenoraColors.gold,
          title: 'Your reviewer rank moved up',
          subtitle: 'You are now in the top 10% · Yesterday',
        ),
      ],
    ),
  );
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    super.key,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: ScenoraColors.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: ScenoraColors.border),
    ),
    child: Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: ScenoraColors.muted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Settings',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Account',
          style: TextStyle(
            color: ScenoraColors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SettingTile(
          icon: Icons.person_outline,
          title: 'Edit profile',
          subtitle: 'Name, photo and bio',
          onTap: () {},
        ),
        SettingTile(
          icon: Icons.lock_outline,
          title: 'Privacy and security',
          subtitle: 'Control your account privacy',
          onTap: () {},
        ),
        const SizedBox(height: 22),
        const Text(
          'Preferences',
          style: TextStyle(
            color: ScenoraColors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SettingTile(
          icon: Icons.notifications_none,
          title: 'Notifications',
          subtitle: 'Likes, comments and follows',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => const NotificationsScreen(),
            ),
          ),
        ),
        SettingTile(
          icon: Icons.dark_mode_outlined,
          title: 'Appearance',
          subtitle: 'Dark mode is on',
          onTap: () {},
        ),
        SettingTile(
          icon: Icons.language,
          title: 'Language',
          subtitle: 'English',
          onTap: () {},
        ),
        const SizedBox(height: 22),
        SettingTile(
          icon: Icons.info_outline,
          title: 'About Scenora',
          subtitle: 'Version 1.0.0',
          onTap: () {},
        ),
        SettingTile(
          icon: Icons.logout,
          title: 'Sign out',
          subtitle: 'You can log back in anytime',
          danger: true,
          onTap: () {},
        ),
      ],
    ),
  );
}

class SettingTile extends StatelessWidget {
  const SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.danger = false,
    super.key,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool danger;
  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: const EdgeInsets.symmetric(vertical: 4),
    leading: Icon(icon, color: danger ? Colors.redAccent : Colors.white70),
    title: Text(
      title,
      style: TextStyle(
        color: danger ? Colors.redAccent : Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: const TextStyle(color: ScenoraColors.muted, fontSize: 12),
    ),
    trailing: const Icon(Icons.chevron_right, color: ScenoraColors.muted),
    onTap: onTap,
  );
}
