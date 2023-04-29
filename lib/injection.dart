import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tvseries_local_data_source.dart';
import 'package:core/data/datasources/tvseries_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tvseries_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:core/utils/http_ssl_pinning.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:movies/presentation/blocs/detail/movie_detail_bloc.dart';
import 'package:movies/presentation/blocs/now_playing/now_playing_movies_bloc.dart';
import 'package:movies/presentation/blocs/popular/popular_movies_bloc.dart';
import 'package:movies/presentation/blocs/search/search_movies_bloc.dart';
import 'package:movies/presentation/blocs/top_rated/top_rated_movies_bloc.dart';
import 'package:movies/presentation/blocs/watchlist/watchlist_movie_bloc.dart';
import 'package:tvseries/presentation/blocs/detail/tvseries_detail_bloc.dart';
import 'package:tvseries/presentation/blocs/on_air/on_air_tvseries_bloc.dart';
import 'package:tvseries/presentation/blocs/popular/popular_tvseries_bloc.dart';
import 'package:tvseries/presentation/blocs/search/search_tvseries_bloc.dart';
import 'package:tvseries/presentation/blocs/top_rated/top_rated_tvseries_bloc.dart';
import 'package:tvseries/presentation/blocs/watchlist/watchlist_tvseries_bloc.dart';
import 'package:tvseries/domain/usecases/get_on_air_tvseries.dart';
import 'package:tvseries/domain/usecases/get_popular_tvseries.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tvseries.dart';
import 'package:tvseries/domain/usecases/get_tvseries_detail.dart';
import 'package:tvseries/domain/usecases/get_tvseries_recommendations.dart';
import 'package:tvseries/domain/usecases/get_tvseries_watchlist_status.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tvseries.dart';
import 'package:tvseries/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:tvseries/domain/usecases/save_tvseries_watchlist.dart';
import 'package:tvseries/domain/usecases/search_tvseries.dart';

final locator = GetIt.instance;

void init() {
  // Movie Provider
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlistMovie: locator(),
      removeWatchlistMovie: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(() => NowPlayingMoviesBloc(
        locator(),
      ));

  // TV Series Provider
  locator.registerFactory(
    () => PopularTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TVSeriesDetailBloc(
      getTVSeriesDetail: locator(),
      getTVSeriesRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlistTVSeries: locator(),
      removeWatchlistTVSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(() => OnAirTVSeriesBloc(
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
