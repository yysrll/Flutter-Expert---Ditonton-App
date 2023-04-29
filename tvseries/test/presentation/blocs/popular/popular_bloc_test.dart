import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_popular_tvseries.dart';
import 'package:tvseries/presentation/blocs/popular/popular_tvseries_bloc.dart';

import '../../../dummy_data/dummy_object.dart';
import 'popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late PopularTVSeriesBloc popularTVSeriesBloc;
  late MockGetPopularTVSeries mockGetPopularTVSeries;

  setUp(() {
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    popularTVSeriesBloc = PopularTVSeriesBloc(
      mockGetPopularTVSeries,
    );
  });

  test('initial state should be empty', () async {
    expect(popularTVSeriesBloc.state, PopularTVSeriesEmpty());
  });

  blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return popularTVSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchPopularTVSeries()),
      expect: () => [
            PopularTVSeriesLoading(),
            PopularTVSeriesLoaded(testTVSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
      });

  blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      'Should emit [Loading, Error] when get popular tvseries is unsuccessful',
      build: () {
        when(mockGetPopularTVSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularTVSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchPopularTVSeries()),
      expect: () {
        return [
          PopularTVSeriesLoading(),
          const PopularTVSeriesError('Server Failure'),
        ];
      },
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
      });

  blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      'Should return [Loading, Empty] when data is empty',
      build: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => const Right(<TVSeries>[]));
        return popularTVSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchPopularTVSeries()),
      expect: () => [
            PopularTVSeriesLoading(),
            PopularTVSeriesEmpty(),
          ],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
      });
}
