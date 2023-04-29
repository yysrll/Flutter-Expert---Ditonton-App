import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/presentation/blocs/detail/movie_detail_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist removeWatchlist;
  late MockSaveWatchlist saveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    removeWatchlist = MockRemoveWatchlist();
    saveWatchlist = MockSaveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlistMovie: saveWatchlist,
      removeWatchlistMovie: removeWatchlist,
    );
  });

  const tId = 1;

  test('initialState should be MovieDetailState.initial()', () {
    expect(movieDetailBloc.state, equals(MovieDetailState.initial()));
  });

  group('get Detail Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [DetailMovie [Loading, Loaded], Recommendation [Loading, Loaded] when get detail movie success',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => const Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(testMovieList));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
        expect: () => [
              MovieDetailState.initial().copyWith(
                state: RequestState.Loading,
              ),
              MovieDetailState.initial().copyWith(
                state: RequestState.Loaded,
                movieDetail: testMovieDetail,
              ),
              MovieDetailState.initial().copyWith(
                state: RequestState.Loaded,
                movieDetail: testMovieDetail,
                movieRecommendationState: RequestState.Loading,
              ),
              MovieDetailState.initial().copyWith(
                state: RequestState.Loaded,
                movieDetail: testMovieDetail,
                movieRecommendationState: RequestState.Loaded,
                movieRecommendation: testMovieList,
              ),
            ],
        verify: (_) {
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [DetailMovie [Loading, Loaded], Recommendation [Loading, Error] when get detail movie success but recommendation not success',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => const Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => const Left(ServerFailure('error')));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
        expect: () => [
              MovieDetailState.initial().copyWith(
                state: RequestState.Loading,
              ),
              MovieDetailState.initial().copyWith(
                state: RequestState.Loaded,
                movieDetail: testMovieDetail,
              ),
              MovieDetailState.initial().copyWith(
                state: RequestState.Loaded,
                movieDetail: testMovieDetail,
                movieRecommendationState: RequestState.Loading,
              ),
              MovieDetailState.initial().copyWith(
                state: RequestState.Loaded,
                movieDetail: testMovieDetail,
                movieRecommendationState: RequestState.Error,
              ),
            ],
        verify: (_) {
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit DetailMovie [Loading, Error] when get detail movie failed',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => const Left(ServerFailure('error')));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
        expect: () => [
              MovieDetailState.initial().copyWith(
                state: RequestState.Loading,
              ),
              MovieDetailState.initial().copyWith(
                state: RequestState.Error,
                message: 'error',
              ),
            ],
        verify: (_) {
          verify(mockGetMovieDetail.execute(tId));
        });
  });

  group('load watchlist status', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Loaded] when load watchlist status true success',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchWatchListStatus(tId)),
        expect: () => [
              MovieDetailState.initial().copyWith(
                isAddedToWatchlist: true,
              ),
            ],
        verify: (_) {
          verify(mockGetWatchListStatus.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Loaded] when load watchlist status false success',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchWatchListStatus(tId)),
        expect: () => [
              MovieDetailState.initial().copyWith(
                isAddedToWatchlist: false,
              ),
            ],
        verify: (_) {
          verify(mockGetWatchListStatus.execute(tId));
        });
  });

  group('added to watchlist movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Loaded] when added to watchlist movie success and set isAddedToWatchlist to true',
        build: () {
          when(saveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Added to Watchlist'));
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const AddWatchlistMovie(testMovieDetail)),
        expect: () => [
              MovieDetailState.initial().copyWith(
                watchlistMessage: 'Added to Watchlist',
                isAddedToWatchlist: false,
              ),
              MovieDetailState.initial().copyWith(
                watchlistMessage: 'Added to Watchlist',
                isAddedToWatchlist: true,
              ),
            ],
        verify: (_) {
          verify(saveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Loaded] when added to watchlist movie failed',
        build: () {
          when(saveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('error')));
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const AddWatchlistMovie(testMovieDetail)),
        expect: () => [
              MovieDetailState.initial().copyWith(
                watchlistMessage: 'error',
                isAddedToWatchlist: false,
              ),
            ],
        verify: (_) {
          verify(saveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(tId));
        });
  });

  group('remove from watchlist movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Loaded] when remove from watchlist movie success and set isAddedToWatchlist to false',
        build: () {
          when(removeWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Removed from Watchlist'));
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const RemoveWatchlistMovie(testMovieDetail)),
        expect: () => [
              MovieDetailState.initial().copyWith(
                watchlistMessage: 'Removed from Watchlist',
                isAddedToWatchlist: false,
              ),
            ],
        verify: (_) {
          verify(removeWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Loaded] when remove from watchlist movie failed',
        build: () {
          when(removeWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('error')));
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const RemoveWatchlistMovie(testMovieDetail)),
        expect: () => [
              MovieDetailState.initial().copyWith(
                watchlistMessage: 'error',
              ),
            ],
        verify: (_) {
          verify(removeWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(tId));
        });
  });
}
