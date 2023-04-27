import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/tvseries/usecases/get_popular_tvseries.dart';
import 'package:ditonton/presentation/tvseries/provider/popular_tvseries_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tvseries_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late PopularTVSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    notifier = PopularTVSeriesNotifier(mockGetPopularTVSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTVSeries = TVSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTVSeriesList = <TVSeries>[tTVSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTVSeries.execute())
        .thenAnswer((_) async => Right(tTVSeriesList));
    // act
    notifier.fetchPopularTVSeries();
    // assert
    expect(notifier.popularState, equals(RequestState.Loading));
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTVSeries.execute())
        .thenAnswer((_) async => Right(tTVSeriesList));
    // act
    await notifier.fetchPopularTVSeries();
    // assert
    expect(notifier.popularTVSeries, equals(tTVSeriesList));
    expect(notifier.popularState, equals(RequestState.Loaded));
    expect(listenerCallCount, 2);
  });
  
  test('should change state to error when data is gotten unsuccessfully', () async {
    // arrange
    when(mockGetPopularTVSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTVSeries();
    // assert
    expect(notifier.popularState, equals(RequestState.Error));
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
