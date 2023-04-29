import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:movies/presentation/blocs/search/search_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMoviesBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = SearchMoviesBloc(mockSearchMovies);
  });

  test('initial state should be empty', () async {
    expect(searchBloc.state, SearchEmpty());
  });

  const query = 'Spider-Man';

  blocTest<SearchMoviesBloc, SearchMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(query))
            .thenAnswer((_) async => Right(testMovieList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChange(query)),
      expect: () => [
            SearchLoading(),
            SearchLoaded(testMovieList),
          ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(query));
      });

  blocTest<SearchMoviesBloc, SearchMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(query)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChange(query)),
      expect: () => [
            SearchLoading(),
            const SearchError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(query));
      });
}
