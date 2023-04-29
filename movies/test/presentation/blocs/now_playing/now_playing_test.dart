import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/presentation/blocs/now_playing/now_playing_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
  });

  test('initial state should be empty', () async {
    expect(nowPlayingMoviesBloc.state, NowPlayingMoviesEmpty());
  });

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(const FetchNowPlayingMovies()),
      expect: () => [
            NowPlayingMoviesLoading(),
            NowPlayingMoviesLoaded(testMovieList),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });

  blocTest('Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(const FetchNowPlayingMovies()),
      expect: () {
        return [
          NowPlayingMoviesLoading(),
          const NowPlayingMoviesError('Server Failure'),
        ];
      },
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, Empty] when get search is successful and empty',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(const FetchNowPlayingMovies()),
      expect: () => [
            NowPlayingMoviesLoading(),
            NowPlayingMoviesEmpty(),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });
}
