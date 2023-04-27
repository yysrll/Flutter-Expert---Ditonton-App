import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:dartz/dartz.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getOnAirTVSeries();
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries();
  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries();
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id);
  Future<Either<Failure, List<TVSeries>>> getTVSeriesRecommendations(int id);
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query);
  Future<Either<Failure, List<TVSeries>>> getWatchlistTVSeries();
  Future<Either<Failure, String>> saveWatchlist(TVSeriesDetail tvSeries);
  Future<Either<Failure, String>> removeFromWatchlist(TVSeriesDetail tvSeries);
  Future<bool> isAddedToWatchlist(int id);
}
