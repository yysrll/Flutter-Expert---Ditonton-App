import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/core/pages/about_page.dart';
import 'package:ditonton/presentation/movie/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/movie/pages/home_movie_page.dart';
import 'package:ditonton/presentation/movie/pages/now_playing_movies_page.dart';
import 'package:ditonton/presentation/movie/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/movie/pages/search_page.dart';
import 'package:ditonton/presentation/movie/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/core/pages/watchlist_page.dart';
import 'package:ditonton/presentation/movie/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/movie/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/movie/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/movie/provider/now_playing_movies_notifier.dart';
import 'package:ditonton/presentation/movie/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/movie/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/movie/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/tvseries/pages/home_tv_series_page.dart';
import 'package:ditonton/presentation/tvseries/pages/on_air_tvseries_page%20copy.dart';
import 'package:ditonton/presentation/tvseries/pages/popular_tvseries_page.dart';
import 'package:ditonton/presentation/tvseries/pages/top_rated_tvseries_page.dart';
import 'package:ditonton/presentation/tvseries/pages/tvseries_detail_page.dart';
import 'package:ditonton/presentation/tvseries/pages/tvseries_search_page.dart';
import 'package:ditonton/presentation/tvseries/provider/on_air_tvseries_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/popular_tvseries_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/top_rated_tvseries_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/tvseries_detail_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/tvseries_list_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/tvseries_search_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/watchlist_tvseries_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<NowPlayingMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTVSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTVSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVSeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTVSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OnAirTVSeriesNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case NowPlayingMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => NowPlayingMoviesPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case HomeTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTVSeriesPage());
            case OnAirTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => OnAirTVSeriesPage());
            case PopularTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTVSeriesPage());
            case TopRatedTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTVSeriesPage());
            case TVSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVSeriesDetailPage(id: id),
                settings: settings,
              );
            case TVSeriesSearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TVSeriesSearchPage());
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
