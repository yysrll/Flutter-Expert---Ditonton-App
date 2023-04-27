import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/tvseries/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/tvseries/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/domain/tvseries/usecases/get_tvseries_watchlist_status.dart';
import 'package:ditonton/domain/tvseries/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/domain/tvseries/usecases/save_tvseries_watchlist.dart';
import 'package:ditonton/presentation/tvseries/provider/tvseries_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object.dart';
import 'tvseries_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTVSeriesDetail,
  GetTVSeriesRecommendations,
  GetWatchlistTVSeriesStatus,
  SaveTVSeriesWatchlist,
  RemoveTVSeriesWatchlist
])
void main() {
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;
  late MockGetWatchlistTVSeriesStatus mockGetWatchlistTVSeriesStatus;
  late MockSaveTVSeriesWatchlist mockSaveTVSeriesWatchlist;
  late MockRemoveTVSeriesWatchlist mockRemoveTVSeriesWatchlist;
  late TVSeriesDetailNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    mockGetWatchlistTVSeriesStatus = MockGetWatchlistTVSeriesStatus();
    mockSaveTVSeriesWatchlist = MockSaveTVSeriesWatchlist();
    mockRemoveTVSeriesWatchlist = MockRemoveTVSeriesWatchlist();
    notifier = TVSeriesDetailNotifier(
      getTVSeriesDetail: mockGetTVSeriesDetail,
      getTVSeriesRecommendations: mockGetTVSeriesRecommendations,
      getWatchlistTVSeriesStatus: mockGetWatchlistTVSeriesStatus,
      saveTVSeriesWatchlist: mockSaveTVSeriesWatchlist,
      removeTVSeriesWatchlist: mockRemoveTVSeriesWatchlist,
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

  group('watchlist', () {
    final tId = 1;
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistTVSeriesStatus.execute(tId))
          .thenAnswer((_) async => true);
      // act
      await notifier.loadWatchlistStatus(tId);
      await untilCalled(mockGetWatchlistTVSeriesStatus.execute(tId));
      // assert
      verify(mockGetWatchlistTVSeriesStatus.execute(tId));
      expect(notifier.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistTVSeriesStatus.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await notifier.addWatchlist(testTVSeriesDetail);
      // assert
      verify(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail))
          .thenAnswer((_) async => Right('Removed from Watchlist'));
      when(mockGetWatchlistTVSeriesStatus.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await notifier.removeWatchlist(testTVSeriesDetail);
      // assert
      verify(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistTVSeriesStatus.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await notifier.addWatchlist(testTVSeriesDetail);

      // assert
      expect(notifier.isAddedToWatchlist, true);
      verify(mockGetWatchlistTVSeriesStatus.execute(testTVSeriesDetail.id));
      expect(notifier.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist status when remove watchlist success',
        () async {
      // arrange
      when(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistTVSeriesStatus.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await notifier.removeWatchlist(testTVSeriesDetail);

      // assert
      expect(notifier.isAddedToWatchlist, false);
      verify(mockGetWatchlistTVSeriesStatus.execute(testTVSeriesDetail.id));
      expect(notifier.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });

    group('on Error', () {
      test('should return error when data is unsuccessful', () async {
        // arrange
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetTVSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTVSeriesList));
        // act
        await notifier.fetchTVSeriesDetail(tId);
        // assert
        expect(notifier.tvSeriesState, RequestState.Error);
        expect(notifier.message, 'Server Failure');
        expect(listenerCallCount, 2);
      });
    });
  });
}
