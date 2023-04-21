import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries_detail.dart';
import 'package:ditonton/domain/tvseries/repositories/tvseries_repository.dart';

class SaveTVSeriesWatchlist {
  final TVSeriesRepository repository;

  SaveTVSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail tvseries) {
    return repository.saveWatchlist(tvseries);
  }
}
