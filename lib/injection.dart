import 'package:ditonton/common/http_ssl_pinning.dart';
import 'package:ditonton/data/core/datasources/db/database_helper.dart';
import 'package:ditonton/data/movie/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/movie/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/movie/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/tvseries/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/data/tvseries/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/data/tvseries/repositories/tvseries_repository_impl.dart';
import 'package:ditonton/domain/movie/repositories/movie_repository.dart';
import 'package:ditonton/domain/movie/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/movie/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/movie/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/movie/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/movie/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/movie/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/movie/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/movie/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/movie/usecases/save_watchlist.dart';
import 'package:ditonton/domain/movie/usecases/search_movies.dart';
import 'package:ditonton/domain/tvseries/repositories/tvseries_repository.dart';
import 'package:ditonton/domain/tvseries/usecases/get_on_air_tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_popular_tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/tvseries/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/domain/tvseries/usecases/get_tvseries_watchlist_status.dart';
import 'package:ditonton/domain/tvseries/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/domain/tvseries/usecases/save_tvseries_watchlist.dart';
import 'package:ditonton/domain/tvseries/usecases/search_tvseries.dart';
import 'package:ditonton/presentation/movie/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/movie/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/movie/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/movie/provider/now_playing_movies_notifier.dart';
import 'package:ditonton/presentation/movie/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/movie/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/movie/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/on_air_tvseries_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/popular_tvseries_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/top_rated_tvseries_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/tvseries_detail_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/tvseries_list_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/tvseries_search_notifier.dart';
import 'package:ditonton/presentation/tvseries/provider/watchlist_tvseries_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // Movie Provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(() => NowPlayingMoviesNotifier(
        locator(),
      ));

  // TV Series Provider
  locator.registerFactory(
    () => TVSeriesListNotifier(
      getOnAirTVSeries: locator(),
      getPopularTVSeries: locator(),
      getTopRatedTVSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTVSeriesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTVSeriesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TVSeriesDetailNotifier(
      getTVSeriesDetail: locator(),
      getTVSeriesRecommendations: locator(),
      getWatchlistTVSeriesStatus: locator(),
      saveTVSeriesWatchlist: locator(),
      removeTVSeriesWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TVSeriesSearchNotifier(
      searchTVSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTVSeriesNotifier(
      getWatchlistTVSeries: locator(),
    ),
  );
  locator.registerFactory(() => OnAirTVSeriesNotifier(
        locator(),
      ));

  // Movie Use Case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // TV Series Use Case
  locator.registerLazySingleton(() => GetOnAirTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveTVSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTVSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeries(locator()));

  // Movies Repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // TV Series Repository
  locator.registerLazySingleton<TVSeriesRepository>(
    () => TVSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // Movie Data Sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // TV Series Data Sources
  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
      () => TVSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
      () => TVSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
