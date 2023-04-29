import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/blocs/watchlist/watchlist_movie_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:tvseries/presentation/blocs/watchlist/watchlist_tvseries_bloc.dart';
import 'package:tvseries/presentation/widgets/tvseries_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMovieBloc>().add(const FetchWatchlistMovie());
      context.read<WatchlistTVSeriesBloc>().add(const FetchWatchlistTVSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(const FetchWatchlistMovie());
    context.read<WatchlistTVSeriesBloc>().add(const FetchWatchlistTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.movie),
                text: 'Movies',
              ),
              Tab(
                icon: Icon(Icons.tv),
                text: 'TV Series',
              ),
            ],
          ),
          title: const Text('Watchlist'),
        ),
        body: TabBarView(
          children: [
            _movieWatchlist(),
            _tvseriesWatchlist(),
          ],
        ),
      ),
    );
  }

  Widget _movieWatchlist() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        builder: (context, state) {
          if (state is WatchlistMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard(movie);
              },
              itemCount: state.movies.length,
            );
          } else if (state is WatchlistMovieError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else if (state is WatchlistMovieEmpty) {
            return const Center(
              key: Key('empty_message'),
              child: Text('Tidak ada data'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _tvseriesWatchlist() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
        builder: (context, state) {
          if (state is WatchlistTVSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTVSeriesLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvseries = state.tvSeriesList[index];
                return TVSeriesCard(
                  tvSeries: tvseries,
                );
              },
              itemCount: state.tvSeriesList.length,
            );
          } else if (state is WatchlistTVSeriesError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else if (state is WatchlistTVSeriesEmpty) {
            return const Center(
              key: Key('empty_message'),
              child: Text('Tidak ada data'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
