import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/presentation/blocs/top_rated/top_rated_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  test('initial state should be empty', () async {
    expect(topRatedMoviesBloc.state, TopRatedMovieEmpty());
  });

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(const FetchTopRatedMovies()),
      expect: () => [
            TopRatedMoviesLoading(),
            TopRatedMoviesLoaded(testMovieList),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(const FetchTopRatedMovies()),
      expect: () => [
            TopRatedMoviesLoading(),
            const TopRatedMoviesError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, Empty] when top rated movies is empty',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => const Right(<Movie>[]));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(const FetchTopRatedMovies()),
      expect: () => [
            TopRatedMoviesLoading(),
            TopRatedMovieEmpty(),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });
}
