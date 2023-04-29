import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/blocs/now_playing/now_playing_movies_bloc.dart';
import '../widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class NowPlayingMoviesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/now-playing-movie';

  const NowPlayingMoviesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NowPlayingMoviesPageState createState() => _NowPlayingMoviesPageState();
}

class _NowPlayingMoviesPageState extends State<NowPlayingMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<NowPlayingMoviesBloc>()
        .add(const FetchNowPlayingMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
            builder: (context, state) {
          if (state is NowPlayingMoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NowPlayingMoviesLoaded) {
            final result = state.movies;
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie);
                },
                itemCount: result.length,
              ),
            );
          } else if (state is NowPlayingMoviesError) {
            return Expanded(
              child: Center(
                key: const Key('error_message'),
                child: Text(state.message),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
