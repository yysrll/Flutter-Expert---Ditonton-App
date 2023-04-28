import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/provider/watchlist_movie_notifier.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/presentation/provider/watchlist_tvseries_notifier.dart';
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
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTVSeriesNotifier>(context, listen: false)
          .fetchWatchlistTVSeries();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTVSeriesNotifier>(context, listen: false)
        .fetchWatchlistTVSeries();
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
      child: Consumer<WatchlistMovieNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = data.watchlistMovies[index];
                return MovieCard(movie);
              },
              itemCount: data.watchlistMovies.length,
            );
          } else {
            return Center(
              key: const Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }

  Widget _tvseriesWatchlist() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<WatchlistTVSeriesNotifier>(
        builder: (context, data, child) {
          if (data.state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.state == RequestState.Loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvseries = data.watchlistTVSeries[index];
                return TVSeriesCard(
                  tvSeries: tvseries,
                );
              },
              itemCount: data.watchlistTVSeries.length,
            );
          } else {
            return Center(
              key: const Key('error_message'),
              child: Text(data.message),
            );
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
