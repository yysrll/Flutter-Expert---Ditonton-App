import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/tvseries/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/presentation/tvseries/provider/tvseries_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object.dart';
import 'tvseries_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTVSeriesDetail, GetTVSeriesRecommendations])
void main() {
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;
  late TVSeriesDetailNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    notifier = TVSeriesDetailNotifier(
      getTVSeriesDetail: mockGetTVSeriesDetail,
      getTVSeriesRecommendations: mockGetTVSeriesRecommendations,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tId = 1;

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
    popularity: 1.0,
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTVSeriesList = <TVSeries>[tTVSeries];

  void _arrangeUsecase() {
    when(mockGetTVSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testTVSeriesDetail));
    when(mockGetTVSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTVSeriesList));
  }

  group('get TV Series Detail', () {
    test('should get data from the use case', () async {
      // arrange
      _arrangeUsecase();
      // act
      await notifier.fetchTVSeriesDetail(tId);
      await untilCalled(mockGetTVSeriesDetail.execute(tId));
      // assert
      verify(mockGetTVSeriesDetail.execute(tId));
    });

    test('should change state to Loading when usecase is called', () async {
      // arrange
      _arrangeUsecase();
      // act
      notifier.fetchTVSeriesDetail(tId);
      // assert
      expect(notifier.tvSeriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change TV Series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await notifier.fetchTVSeriesDetail(tId);
      // assert
      expect(notifier.tvSeriesState, RequestState.Loaded);
      expect(notifier.tvSeries, testTVSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation TV Series when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await notifier.fetchTVSeriesDetail(tId);
      // assert
      expect(notifier.tvSeriesState, RequestState.Loaded);
      expect(notifier.tvSeriesRecommendations, tTVSeriesList);
      expect(listenerCallCount, 3);
    });

    test('should change state to error when data is gotten unsuccessfully',
        () async {
      // arrange
      when(mockGetTVSeriesDetail.execute(tId))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTVSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchTVSeriesDetail(tId);
      // assert
      expect(notifier.tvSeriesState, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('get TV Series Recommendation', () {
    test('should get data from the use case', () async {
      // arrange
      _arrangeUsecase();
      // act
      await notifier.fetchTVSeriesDetail(tId);
      await untilCalled(mockGetTVSeriesRecommendations.execute(tId));
      // assert
      verify(mockGetTVSeriesRecommendations.execute(tId));
      expect(notifier.tvSeriesRecommendations, tTVSeriesList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await notifier.fetchTVSeriesDetail(tId);
      // assert
      expect(notifier.recommendationState, RequestState.Loaded);
      expect(notifier.tvSeriesRecommendations, tTVSeriesList);
    });

    test('should update error state and message when request unsuccessful',
        () async {
      // arrange
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVSeriesDetail));
      when(mockGetTVSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchTVSeriesDetail(tId);
      // assert
      expect(notifier.recommendationState, RequestState.Error);
      expect(notifier.message, 'Server Failure');
    });
  });
}
