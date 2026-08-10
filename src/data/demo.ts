export const img = (path: string, size = "w500") => `https://image.tmdb.org/t/p/${size}${path}`;

export const movies = [
  { id: "interstellar", title: "Interstellar", year: "2014", runtime: "2h 49m", genres: "Adventure, Drama, Sci-Fi", rating: 4.8, external: 8.7, poster: img("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg"), backdrop: img("/xJHokMbljvjADYdit5fK5VQsXEG.jpg", "original"), overview: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity’s survival." },
  { id: "dark-knight", title: "The Dark Knight", year: "2008", runtime: "2h 32m", genres: "Action, Crime, Drama", rating: 4.9, external: 9.0, poster: img("/qJ2tW6WMUDux911r6m7haRef0WH.jpg"), backdrop: img("/hqkIcbrOHL86UncnHIsHVcVmzue.jpg", "original"), overview: "Batman raises the stakes in his war on crime as Gotham faces a criminal mastermind." },
  { id: "inception", title: "Inception", year: "2010", runtime: "2h 28m", genres: "Action, Sci-Fi, Thriller", rating: 4.7, external: 8.8, poster: img("/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg"), backdrop: img("/s3TBrRGB1iav7gFOCNx3H31MoES.jpg", "original"), overview: "A thief who steals corporate secrets through dream-sharing technology is given an inverse task." },
  { id: "shawshank", title: "The Shawshank Redemption", year: "1994", runtime: "2h 22m", genres: "Drama", rating: 4.9, external: 9.3, poster: img("/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg"), backdrop: img("/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg", "original"), overview: "Two imprisoned men bond over years, finding solace and eventual redemption through common decency." },
  { id: "godfather", title: "The Godfather", year: "1972", runtime: "2h 55m", genres: "Crime, Drama", rating: 4.8, external: 9.2, poster: img("/3bhkrj58Vtu7enYsRolD1fZdja1.jpg"), backdrop: img("/tmU7GeKVybMWFButWEGl2M4GeiP.jpg", "original"), overview: "The aging patriarch of an organized crime dynasty transfers control to his reluctant son." },
  { id: "dune", title: "Dune: Part Two", year: "2024", runtime: "2h 46m", genres: "Sci-Fi, Adventure", rating: 4.6, external: 8.5, poster: img("/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg"), backdrop: img("/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg", "original"), overview: "Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators." },
  { id: "mission", title: "Mission: Impossible – The Final Reckoning", year: "2025", runtime: "2h 49m", genres: "Action, Thriller", rating: 4.5, external: 8.9, poster: img("/z53D72EAOxGRqdr7KXXWp9dJiDe.jpg"), backdrop: img("/2Nti3gYAX513wvhp8IiLL6ZDyOm.jpg", "original"), overview: "Ethan Hunt and his IMF team race against time to stop a dangerous AI entity from falling into the wrong hands." },
];

export const people = [
  { name: "Naveed Ahmed", username: "naveed", rating: 4.9, reviews: "1.2K", avatar: "https://i.pravatar.cc/160?img=12" },
  { name: "Farhana Islam", username: "farhana", rating: 4.8, reviews: "982", avatar: "https://i.pravatar.cc/160?img=47" },
  { name: "Sami Ul Haque", username: "sami", rating: 4.8, reviews: "876", avatar: "https://i.pravatar.cc/160?img=11" },
  { name: "Tania Rahman", username: "tania", rating: 4.7, reviews: "754", avatar: "https://i.pravatar.cc/160?img=44" },
  { name: "Mahin", username: "mahin", rating: 4.7, reviews: "693", avatar: "https://i.pravatar.cc/160?img=13" },
];

export const genres = ["Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Fantasy", "Horror", "Mystery", "Romance", "Sci-Fi", "Thriller", "War", "Western"];

export const posts = [
  { id: "p1", user: "Shahrier Emon", username: "shahrieremon", avatar: "https://i.pravatar.cc/160?img=68", movie: movies[0], time: "2h ago", rating: 4, tags: ["SciFi", "Masterpiece", "MindBlowing"], text: "A masterpiece that makes you question your entire existence. Nolan’s direction, the music, everything was beyond perfect. 🚀", images: [movies[0].backdrop, img("/pbrkL804c8yAv3zBZR4QPEafpAR.jpg", "w780"), img("/6oaL4DP75yABrd5EbC4H2zq5ghc.jpg", "w780")], likes: 189, comments: 32, shares: 18 },
  { id: "p2", user: "Tania Rahman", username: "tania", avatar: people[3].avatar, movie: movies[5], time: "5h ago", rating: 5, tags: ["Epic", "MustWatch", "Cinematic"], text: "Denis Villeneuve did it again! The visuals, the score, the story—absolutely breathtaking. 🔥", images: [movies[5].poster], likes: 142, comments: 21, shares: 9 },
];
