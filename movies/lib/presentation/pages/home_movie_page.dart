import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/blocs/now_playing/now_playing_movies_bloc.dart';
import 'package:movies/presentation/blocs/popular/popular_movies_bloc.dart';
import 'package:movies/presentation/blocs/top_rated/top_rated_movies_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/now_playing_movies_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/home-movies';

  const HomeMoviePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesBloc>().add(const FetchNowPlayingMovies());
      context.read<PopularMoviesBloc>().add(const FetchPopularMovies());
      context.read<TopRatedMoviesBloc>().add(const FetchTopRatedMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(
      title: const Text('Movies'),
      isMovies: true,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () => Navigator.pushNamed(
                    context, NowPlayingMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                  builder: (context, state) {
                if (state is NowPlayingMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingMoviesLoaded) {
                  final result = state.movies;
                  return MovieList(result);
                } else if (state is NowPlayingMoviesError) {
                  return Text(state.message);
                } else if (state is NowPlayingMoviesEmpty) {
                  return const Text('Tidak ada data');
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                  builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMoviesLoaded) {
                  return MovieList(state.movies);
                } else if (state is PopularMoviesError) {
                  return const Text('Failed');
                } else if (state is PopularMoviesEmpty) {
                  return const Text('Tidak ada data');
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                  builder: (context, state) {
                if (state is TopRatedMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMoviesLoaded) {
                  return MovieList(state.movies);
                } else if (state is TopRatedMoviesError) {
                  return const Text('Failed');
                } else if (state is TopRatedMovieEmpty) {
                  return const Text('Tidak ada data');
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
