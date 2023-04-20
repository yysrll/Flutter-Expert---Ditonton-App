import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/tvseries/models/tvseries_detail_model.dart';
import 'package:ditonton/data/tvseries/models/tvseries_model.dart';
import 'package:ditonton/data/tvseries/repositories/tvseries_repository_impl.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object.dart';
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

  group('popular TV Series', () {
    test('should return list of TV Series when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenAnswer((_) async => tTVSeriesModelList);

      // act
      final result = await repository.getPopularTVSeries();

      // assert
      verify(mockRemoteDataSource.getPopularTVSeries());
      final resultList = result.getOrElse(() => []);

      expect(resultList, tTVSeriesList);
    });

    test('should return a ServerFailure when the call is unsuccessful',
        () async {
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenThrow(ServerException());

      final result = await repository.getPopularTVSeries();

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTVSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('top Rated TV Series', () {
    test('should return list of TV Series when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenAnswer((_) async => tTVSeriesModelList);

      // act
      final result = await repository.getTopRatedTVSeries();

      // assert
      verify(mockRemoteDataSource.getTopRatedTVSeries());
      final resultList = result.getOrElse(() => []);

      expect(resultList, tTVSeriesList);
    });

    test('should return a ServerFailure when the call is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(ServerException());

      final result = await repository.getTopRatedTVSeries();

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTVSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('detail TV series', () {
    final tId = 1;
    final tTVSeriesDetailModel = TVSeriesDetailModel(
      backdropPath: 'backdropPath',
      episodeRunTime: [1, 2, 3],
      firstAirDate: 'firstAirDate',
      genres: [],
      id: 1,
      inProduction: true,
      languages: ['languages'],
      lastAirDate: 'lastAirDate',
      name: 'name',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ['originCountry'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      seasons: [],
      status: 'status',
      type: 'type',
      voteAverage: 1,
      voteCount: 1,
      tagline: 'tagLine',
    );

    test(
        'should return TV Series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesDetail(tId))
          .thenAnswer((_) async => tTVSeriesDetailModel);
      // act
      final result = await repository.getTVSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesDetail(tId));
      expect(result, equals(Right(testTVSeriesDetail)));
    });

    test('should return a ServerFailure when the call is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesDetail(tId))
          .thenThrow(ServerException());

      // act
      final result = await repository.getTVSeriesDetail(tId);

      // assert
      verify(mockRemoteDataSource.getTVSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get TV Series recommendation', () {
    final tId = 1;
    final tTVSeriesModelList = <TVSeriesModel>[];
    final tTVSeriesList = <TVSeries>[];

    test(
        'should return list of TV Series when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenAnswer((_) async => tTVSeriesModelList);
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTVSeriesList));
    });

    test('should return a ServerFailure when the call is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenThrow(ServerException());

      // act
      final result = await repository.getTVSeriesRecommendations(tId);

      // assert
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('serach TV Series', () {
    final tQuery = 'query';

    test(
        'should return list of TV Series when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVSeries(tQuery))
          .thenAnswer((_) async => tTVSeriesModelList);
      // act
      final result = await repository.searchTVSeries(tQuery);
      // assert
      verify(mockRemoteDataSource.searchTVSeries(tQuery));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTVSeriesList));
    });

    test('should return a ServerFailure when the call is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVSeries(tQuery))
          .thenThrow(ServerException());

      // act
      final result = await repository.searchTVSeries(tQuery);

      // assert
      verify(mockRemoteDataSource.searchTVSeries(tQuery));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTVSeries(tQuery);
      // assert
      verify(mockRemoteDataSource.searchTVSeries(tQuery));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
  
}
