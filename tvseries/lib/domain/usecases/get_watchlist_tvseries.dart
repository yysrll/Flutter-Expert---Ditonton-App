import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:dartz/dartz.dart';

class GetWatchlistTVSeries {
  final TVSeriesRepository repository;

  GetWatchlistTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getWatchlistTVSeries();
  }
}
