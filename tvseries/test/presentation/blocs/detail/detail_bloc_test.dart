import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_tvseries_detail.dart';
import 'package:tvseries/domain/usecases/get_tvseries_recommendations.dart';
import 'package:tvseries/domain/usecases/get_tvseries_watchlist_status.dart';
import 'package:tvseries/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:tvseries/domain/usecases/save_tvseries_watchlist.dart';
import 'package:tvseries/presentation/blocs/detail/tvseries_detail_bloc.dart';

import '../../../dummy_data/dummy_object.dart';
import 'detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTVSeriesDetail,
  GetTVSeriesRecommendations,
  GetWatchlistTVSeriesStatus,
  SaveTVSeriesWatchlist,
  RemoveTVSeriesWatchlist,
])
void main() {
  late TVSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;
  late MockGetWatchlistTVSeriesStatus mockGetWatchlistTVSeriesStatus;
  late MockSaveTVSeriesWatchlist mockSaveTVSeriesWatchlist;
  late MockRemoveTVSeriesWatchlist mockRemoveTVSeriesWatchlist;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    mockGetWatchlistTVSeriesStatus = MockGetWatchlistTVSeriesStatus();
    mockSaveTVSeriesWatchlist = MockSaveTVSeriesWatchlist();
    mockRemoveTVSeriesWatchlist = MockRemoveTVSeriesWatchlist();

    tvSeriesDetailBloc = TVSeriesDetailBloc(
      getTVSeriesDetail: mockGetTVSeriesDetail,
      getTVSeriesRecommendations: mockGetTVSeriesRecommendations,
      getWatchListStatus: mockGetWatchlistTVSeriesStatus,
      saveWatchlistTVSeries: mockSaveTVSeriesWatchlist,
      removeWatchlistTVSeries: mockRemoveTVSeriesWatchlist,
    );
  });

  const tId = 1;

  test('initialState should be MovieDetailState.initial()', () async {
    expect(tvSeriesDetailBloc.state, equals(TVSeriesDetailState.initial()));
  });

  group('get Detail TV Series', () {
    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Should emit [DetailMovie [Loading, Loaded], Recommendation [Loading, Loaded] when get detail tv series success',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTVSeriesDetail));
        when(mockGetTVSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTVSeriesList));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTVSeriesDetail(tId)),
      expect: () => [
        TVSeriesDetailState.initial().copyWith(
          state: RequestState.Loading,
        ),
        TVSeriesDetailState.initial().copyWith(
          state: RequestState.Loaded,
          tvSeriesDetail: testTVSeriesDetail,
        ),
        TVSeriesDetailState.initial().copyWith(
          state: RequestState.Loaded,
          tvSeriesDetail: testTVSeriesDetail,
          tvSeriesRecommendationState: RequestState.Loading,
        ),
        TVSeriesDetailState.initial().copyWith(
          state: RequestState.Loaded,
          tvSeriesDetail: testTVSeriesDetail,
          tvSeriesRecommendationState: RequestState.Loaded,
          tvSeriesRecommendation: testTVSeriesList,
        ),
      ],
      verify: (_) {
        verify(mockGetTVSeriesDetail.execute(tId));
        verify(mockGetTVSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Should emit [DetailMovie [Loading, Loaded], Recommendation [Loading, Error] when get detail tv series success but recommendation not',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId)).thenAnswer(
          (_) async => const Right(testTVSeriesDetail),
        );
        when(mockGetTVSeriesRecommendations.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTVSeriesDetail(tId)),
      expect: () => [
        TVSeriesDetailState.initial().copyWith(
          state: RequestState.Loading,
        ),
        TVSeriesDetailState.initial().copyWith(
          state: RequestState.Loaded,
          tvSeriesDetail: testTVSeriesDetail,
        ),
        TVSeriesDetailState.initial().copyWith(
          state: RequestState.Loaded,
          tvSeriesDetail: testTVSeriesDetail,
          tvSeriesRecommendationState: RequestState.Loading,
        ),
        TVSeriesDetailState.initial().copyWith(
            state: RequestState.Loaded,
            tvSeriesDetail: testTVSeriesDetail,
            tvSeriesRecommendationState: RequestState.Error,
            message: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockGetTVSeriesDetail.execute(tId));
        verify(mockGetTVSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Should emit [DetailMovie [Loading, Error] when get detail tv series failed',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId)).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTVSeriesDetail(tId)),
      expect: () => [
        TVSeriesDetailState.initial().copyWith(
          state: RequestState.Loading,
        ),
        TVSeriesDetailState.initial().copyWith(
          state: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
      verify: (_) {
        verify(mockGetTVSeriesDetail.execute(tId));
      },
    );
  });

  group('load watchlist status', () {
    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Should emit [Loading, Loaded] when load watchlist status true success',
      build: () {
        when(mockGetWatchlistTVSeriesStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchWatchListStatus(tId)),
      expect: () => [
        TVSeriesDetailState.initial().copyWith(isAddedToWatchlist: true),
      ],
      verify: (_) {
        verify(mockGetWatchlistTVSeriesStatus.execute(tId));
      },
    );

    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Should emit [Loading, Loaded] when load watchlist status false success',
      build: () {
        when(mockGetWatchlistTVSeriesStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchWatchListStatus(tId)),
      expect: () => [
        TVSeriesDetailState.initial().copyWith(
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockGetWatchlistTVSeriesStatus.execute(tId));
      },
    );
  });

  group('added to watchlist', () {
    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Should emit isAddedToWatchlist to true when added to watchlist success',
      build: () {
        when(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistTVSeriesStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistTVSeries(testTVSeriesDetail)),
      expect: () => [
        TVSeriesDetailState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: false,
        ),
        TVSeriesDetailState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail));
        verify(mockGetWatchlistTVSeriesStatus.execute(tId));
      },
    );

    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Should emit isAddedToWatchlist to false when added to watchlist failed',
      build: () {
        when(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
        when(mockGetWatchlistTVSeriesStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistTVSeries(testTVSeriesDetail)),
      expect: () => [
        TVSeriesDetailState.initial().copyWith(
          watchlistMessage: 'Error',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail));
        verify(mockGetWatchlistTVSeriesStatus.execute(tId));
      },
    );
  });

  group('remove from watchlist tv series', () {
    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Should emit isAddedToWatchlist to false when remove from watchlist success',
      build: () {
        when(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchlistTVSeriesStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) =>
          bloc.add(const RemoveWatchlistTVSeries(testTVSeriesDetail)),
      expect: () => [
        TVSeriesDetailState.initial().copyWith(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail));
        verify(mockGetWatchlistTVSeriesStatus.execute(tId));
      },
    );

    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Should emit watchlistMessage error when remove from watchlist failed',
      build: () {
        when(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
        when(mockGetWatchlistTVSeriesStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) =>
          bloc.add(const RemoveWatchlistTVSeries(testTVSeriesDetail)),
      expect: () => [
        TVSeriesDetailState.initial().copyWith(
          watchlistMessage: 'Error',
        ),
        TVSeriesDetailState.initial()
            .copyWith(watchlistMessage: 'Error', isAddedToWatchlist: true),
      ],
      verify: (_) {
        verify(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail));
        verify(mockGetWatchlistTVSeriesStatus.execute(tId));
      },
    );
  });
}
