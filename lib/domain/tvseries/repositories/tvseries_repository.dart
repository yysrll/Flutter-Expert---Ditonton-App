import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getOnAirTVSeries();
}