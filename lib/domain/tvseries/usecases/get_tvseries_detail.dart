import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries_detail.dart';
import 'package:ditonton/domain/tvseries/repositories/tvseries_repository.dart';

class GetTVSeriesDetail {
  final TVSeriesRepository repository;

  GetTVSeriesDetail(this.repository);

  Future<Either<Failure, TVSeriesDetail>> execute(int id) async {
    return await repository.getTVSeriesDetail(id);
  }
}
