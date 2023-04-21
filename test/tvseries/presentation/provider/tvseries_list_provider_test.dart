import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_on_air_tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_popular_tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/tvseries/provider/tvseries_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvseries_list_provider_test.mocks.dart';

@GenerateMocks([GetOnAirTVSeries, GetPopularTVSeries, GetTopRatedTVSeries])
void main() {
  late TVSeriesListNotifier provider;
  late MockGetOnAirTVSeries mockGetOnAirTVSeries;
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAirTVSeries = MockGetOnAirTVSeries();
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    provider = TVSeriesListNotifier(
      getOnAirTVSeries: mockGetOnAirTVSeries,
      getPopularTVSeries: mockGetPopularTVSeries,
      getTopRatedTVSeries: mockGetTopRatedTVSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTVSeries = TVSeries(
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

  final tTVSeriesList = <TVSeries>[tTVSeries];

  group('on Air TV Series', () {
    test('initialState should be Empty', () {
      expect(provider.onAirState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnAirTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchOnAirTVSeries();
      // assert
      verify(mockGetOnAirTVSeries.execute());
    });

    test('should change state to Loading when usecase is called', () async {
      // arrange
      when(mockGetOnAirTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchOnAirTVSeries();

      // assert
      expect(provider.onAirState, equals(RequestState.Loading));
    });

    test('should emit Error when getting data fails', () async {
      // arrange
      when(mockGetOnAirTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchOnAirTVSeries();

      // assert
      expect(provider.onAirState, equals(RequestState.Error));
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetOnAirTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchOnAirTVSeries();
      // assert
      expect(provider.onAirState, equals(RequestState.Loaded));
      expect(provider.onAirTVSeries, equals(tTVSeriesList));
      expect(listenerCallCount, 2);
    });
  });

  group('popular TV Series', () {
    test('initialState should be Empty', () {
      expect(provider.popularState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchPopularTVSeries();
      // assert
      verify(mockGetPopularTVSeries.execute());
    });

    test('should change state to Loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchPopularTVSeries();

      // assert
      expect(provider.popularState, equals(RequestState.Loading));
    });

    test('should emit Error when getting data fails', () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchPopularTVSeries();

      // assert
      expect(provider.popularState, equals(RequestState.Error));
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchPopularTVSeries();
      // assert
      expect(provider.popularState, equals(RequestState.Loaded));
      expect(provider.popularTVSeries, equals(tTVSeriesList));
      expect(listenerCallCount, 2);
    });
  });

  group('top Rated TV Series', () {
    test('initialState should be Empty', () {
      expect(provider.topRatedState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchTopRatedTVSeries();
      // assert
      verify(mockGetTopRatedTVSeries.execute());
    });

    test('should change state to Loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchTopRatedTVSeries();

      // assert
      expect(provider.topRatedState, equals(RequestState.Loading));
    });

    test('should emit Error when getting data fails', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchTopRatedTVSeries();

      // assert
      expect(provider.topRatedState, equals(RequestState.Error));
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchTopRatedTVSeries();
      // assert
      expect(provider.topRatedState, equals(RequestState.Loaded));
      expect(provider.topRatedTVSeries, equals(tTVSeriesList));
      expect(listenerCallCount, 2);
    });
  });
}
