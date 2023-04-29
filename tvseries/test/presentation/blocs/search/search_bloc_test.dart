import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/search_tvseries.dart';
import 'package:tvseries/presentation/blocs/search/search_tvseries_bloc.dart';

import '../../../dummy_data/dummy_object.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late SearchTVSeriesBloc searchTVSeriesBloc;
  late MockSearchTVSeries mockSearchTVSeries;

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    searchTVSeriesBloc = SearchTVSeriesBloc(mockSearchTVSeries);
  });

  test('initial state should be empty', () {
    expect(searchTVSeriesBloc.state, SearchTVSeriesEmpty());
  });

  blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVSeries.execute('naruto'))
          .thenAnswer((_) async => Right(testTVSeriesList));
      return searchTVSeriesBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChange('naruto')),
    expect: () =>
        [SearchTVSeriesLoading(), SearchTVSeriesLoaded(testTVSeriesList)],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute('naruto'));
    },
  );

  blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockSearchTVSeries.execute('naruto'))
          .thenAnswer((_) async => const Right(<TVSeries>[]));
      return searchTVSeriesBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChange('naruto')),
    expect: () => [SearchTVSeriesLoading(), SearchTVSeriesEmpty()],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute('naruto'));
    },
  );

  blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
    'Should emit [Loading, Error] when get data is error',
    build: () {
      when(mockSearchTVSeries.execute('naruto'))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchTVSeriesBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChange('naruto')),
    expect: () =>
        [SearchTVSeriesLoading(), const SearchTVSeriesError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute('naruto'));
    },
  );
}
