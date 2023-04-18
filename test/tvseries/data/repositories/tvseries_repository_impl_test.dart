import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/tvseries/models/tvseries_model.dart';
import 'package:ditonton/data/tvseries/repositories/tvseries_repository_impl.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesRepositoryImpl repository;
  late MockTVSeriesRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVSeriesRemoteDataSource();
    repository = TVSeriesRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  final tTVSeriesModel = TVSeriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeries = TVSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTVSeriesModelList = <TVSeriesModel>[tTVSeriesModel];
  final tTVSeriesList = <TVSeries>[tTvSeries];

  group('on Air TV Series', () {
    test('should return list of TV Series when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnAirTVSeries())
          .thenAnswer((_) async => tTVSeriesModelList);

      // act
      final result = await repository.getOnAirTVSeries();

      // assert
      verify(mockRemoteDataSource.getOnAirTVSeries());
      final resultList = result.getOrElse(() => []);

      expect(resultList, tTVSeriesList);
    });

    test('should return a ServerFailure when the call is unsuccessful',
        () async {
      when(mockRemoteDataSource.getOnAirTVSeries())
          .thenThrow(ServerException());

      final result = await repository.getOnAirTVSeries();

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnAirTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnAirTVSeries();
      // assert
      verify(mockRemoteDataSource.getOnAirTVSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
