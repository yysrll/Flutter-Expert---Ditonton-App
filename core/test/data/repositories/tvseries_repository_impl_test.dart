import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data/models/tvseries_detail_model.dart';
import 'package:core/data/models/tvseries_model.dart';
import 'package:core/data/repositories/tvseries_repository_impl.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tvseries/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesRepositoryImpl repository;
  late MockTVSeriesRemoteDataSource mockRemoteDataSource;
  late MockTVSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVSeriesRemoteDataSource();
    mockLocalDataSource = MockTVSeriesLocalDataSource();
    repository = TVSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tTVSeriesModel = TVSeriesModel(
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
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: const ['originCountry'],
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

      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnAirTVSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnAirTVSeries();
      // assert
      verify(mockRemoteDataSource.getOnAirTVSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
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

      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTVSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
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

      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTVSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('detail TV series', () {
    const tId = 1;
    const tTVSeriesDetailModel = TVSeriesDetailModel(
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
      expect(result, equals(const Right(testTVSeriesDetail)));
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
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get TV Series recommendation', () {
    const tId = 1;
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
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('search TV Series', () {
    const tQuery = 'query';

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
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVSeries(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTVSeries(tQuery);
      // assert
      verify(mockRemoteDataSource.searchTVSeries(tQuery));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('save TV Series watchlist', () {
    test('should return success message when save watchlist is successful',
        () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTVSeriesDetail);
      // assert
      verify(mockLocalDataSource.insertWatchlist(testTVSeriesTable));
      expect(result, equals(const Right('Added to Watchlist')));
    });

    test('should return a DatabaseFailure when the call is unsuccessful',
        () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      // act
      final result = await repository.saveWatchlist(testTVSeriesDetail);

      // assert
      verify(mockLocalDataSource.insertWatchlist(testTVSeriesTable));
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove TV Series watchlist', () {
    test('should return success message when remove watchlist is successful',
        () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 'Removed from Watchlist');
      // act
      final result = await repository.removeFromWatchlist(testTVSeriesDetail);
      // assert
      verify(mockLocalDataSource.removeWatchlist(testTVSeriesTable));
      expect(result, equals(const Right('Removed from Watchlist')));
    });

    test('should return a DatabaseFailure when the call is unsuccessful',
        () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      // act
      final result = await repository.removeFromWatchlist(testTVSeriesDetail);

      // assert
      verify(mockLocalDataSource.removeWatchlist(testTVSeriesTable));
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return true when the TV Series is on watchlist', () async {
      // arrange
      when(mockLocalDataSource.getTVSeriesById(testTVSeriesTable.id))
          .thenAnswer((_) async => testTVSeriesTable);
      // act
      final result = await repository.isAddedToWatchlist(testTVSeriesDetail.id);
      // assert
      verify(mockLocalDataSource.getTVSeriesById(testTVSeriesTable.id));
      expect(result, equals(true));
    });

    test('should return false when the TV Series is not on watchlist',
        () async {
      // arrange
      when(mockLocalDataSource.getTVSeriesById(testTVSeriesTable.id))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(testTVSeriesDetail.id);
      // assert
      verify(mockLocalDataSource.getTVSeriesById(testTVSeriesTable.id));
      expect(result, equals(false));
    });
  });

  group('get TV Series watchlist', () {
    test('should return list of TV Series from database', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTVSeries())
          .thenAnswer((_) async => [testTVSeriesTable]);
      // act
      final result = await repository.getWatchlistTVSeries();
      // assert
      verify(mockLocalDataSource.getWatchlistTVSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTVSeries]);
    });
  });
}
