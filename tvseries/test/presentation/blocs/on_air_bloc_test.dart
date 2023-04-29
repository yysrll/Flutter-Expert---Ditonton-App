import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_on_air_tvseries.dart';
import 'package:tvseries/presentation/blocs/on_air/on_air_tvseries_bloc.dart';

import '../../dummy_data/dummy_object.dart';
import 'on_air_bloc_test.mocks.dart';

@GenerateMocks([GetOnAirTVSeries])
void main() {
  late OnAirTVSeriesBloc onAirTVSeriesBloc;
  late MockGetOnAirTVSeries mockGetOnAirTVSeries;

  setUp(() {
    mockGetOnAirTVSeries = MockGetOnAirTVSeries();
    onAirTVSeriesBloc = OnAirTVSeriesBloc(
      mockGetOnAirTVSeries,
    );
  });

  test('initial state should be empty', () async {
    expect(onAirTVSeriesBloc.state, OnAirTVSeriesEmpty());
  });

  blocTest<OnAirTVSeriesBloc, OnAirTVSeriesState>('Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetOnAirTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return onAirTVSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchOnAirTVSeries()),
      expect: () => [
            OnAirTVSeriesLoading(),
            OnAirTVSeriesLoaded(testTVSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetOnAirTVSeries.execute());
      });

  blocTest<OnAirTVSeriesBloc, OnAirTVSeriesState>('Should emit [Loading, Error] when get on air tvseries is unsuccessful',
      build: () {
        when(mockGetOnAirTVSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return onAirTVSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchOnAirTVSeries()),
      expect: () {
        return [
          OnAirTVSeriesLoading(),
          const OnAirTVSeriesError('Server Failure'),
        ];
      },
      verify: (bloc) {
        verify(mockGetOnAirTVSeries.execute());
      });

  blocTest<OnAirTVSeriesBloc, OnAirTVSeriesState>(
      'Should emit [Loading, Empty] when get empty on air tvseries',
      build: () {
        when(mockGetOnAirTVSeries.execute()).thenAnswer(
            (_) async => const Right(<TVSeries>[]));
        return onAirTVSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchOnAirTVSeries()),
      expect: () {
        return [
          OnAirTVSeriesLoading(),
          OnAirTVSeriesEmpty(),
        ];
      },
      verify: (bloc) {
        verify(mockGetOnAirTVSeries.execute());
      });
}
