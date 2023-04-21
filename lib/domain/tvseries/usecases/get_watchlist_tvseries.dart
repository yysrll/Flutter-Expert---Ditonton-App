import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries.dart';
import 'package:ditonton/domain/tvseries/repositories/tvseries_repository.dart';

class GetWatchlistTVSeries {
  final TVSeriesRepository repository;

  GetWatchlistTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getWatchlistTVSeries();
  }
}
