import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tvseries.dart';
import 'package:tvseries/presentation/blocs/watchlist/watchlist_tvseries_bloc.dart';

import '../../../dummy_data/dummy_object.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTVSeries])
void main() {
  late WatchlistTVSeriesBloc watchlistTVSeriesBloc;
  late MockGetWatchlistTVSeries mockGetWatchlistTVSeries;

  setUp(() {
    mockGetWatchlistTVSeries = MockGetWatchlistTVSeries();
    watchlistTVSeriesBloc = WatchlistTVSeriesBloc(mockGetWatchlistTVSeries);
  });

  test('initialState should be WatchlistTVSeriesEmpty', () {
    expect(watchlistTVSeriesBloc.state, equals(WatchlistTVSeriesEmpty()));
  });

  blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      return watchlistTVSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchWatchlistTVSeries()),
    expect: () => [
      WatchlistTVSeriesLoading(),
      WatchlistTVSeriesLoaded(testTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVSeries.execute());
    },
  );

  blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => const Right(<TVSeries>[]));
      return watchlistTVSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchWatchlistTVSeries()),
    expect: () => [
      WatchlistTVSeriesLoading(),
      WatchlistTVSeriesEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVSeries.execute());
    },
  );

  blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
    'Should emit [Loading, Error] when get data is error',
    build: () {
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistTVSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchWatchlistTVSeries()),
    expect: () => [
      WatchlistTVSeriesLoading(),
      const WatchlistTVSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVSeries.execute());
    },
  );
}
