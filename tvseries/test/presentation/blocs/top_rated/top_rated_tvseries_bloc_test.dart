import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tvseries.dart';
import 'package:tvseries/presentation/blocs/top_rated/top_rated_tvseries_bloc.dart';

import '../../../dummy_data/dummy_object.dart';
import 'top_rated_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late TopRatedTVSeriesBloc topRatedTVSeriesBloc;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    topRatedTVSeriesBloc = TopRatedTVSeriesBloc(mockGetTopRatedTVSeries);
  });

  test('initial state should be empty', () async {
    expect(topRatedTVSeriesBloc.state, TopRatedTVSeriesEmpty());
  });

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return topRatedTVSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchTopRatedTVSeries()),
      expect: () => [
            TopRatedTVSeriesLoading(),
            TopRatedTVSeriesLoaded(testTVSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      });

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'Should emit [Loading, Error] when get top rated tvseries is unsuccessful',
      build: () {
        when(mockGetTopRatedTVSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedTVSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchTopRatedTVSeries()),
      expect: () {
        return [
          TopRatedTVSeriesLoading(),
          const TopRatedTVSeriesError('Server Failure'),
        ];
      },
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      });

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'Should emit [Loading, Empty] when get top rated tvseries is empty',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => const Right(<TVSeries>[]));
        return topRatedTVSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchTopRatedTVSeries()),
      expect: () {
        return [
          TopRatedTVSeriesLoading(),
          TopRatedTVSeriesEmpty(),
        ];
      },
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      });
}
