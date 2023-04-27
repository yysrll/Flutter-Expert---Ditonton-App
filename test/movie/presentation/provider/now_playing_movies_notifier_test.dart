import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/movie/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/movie/provider/now_playing_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies getNowPlayingMovies;
  late NowPlayingMoviesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    getNowPlayingMovies = MockGetNowPlayingMovies();
    notifier = NowPlayingMoviesNotifier(getNowPlayingMovies)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(getNowPlayingMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    notifier.fetchNowPlayingMovies();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(getNowPlayingMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    await notifier.fetchNowPlayingMovies();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movies, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should change state to error when data is gotten unsuccessfully',
      () async {
    // arrange
    when(getNowPlayingMovies.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchNowPlayingMovies();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
