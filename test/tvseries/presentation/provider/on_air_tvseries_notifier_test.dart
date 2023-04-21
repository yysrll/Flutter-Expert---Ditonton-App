import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_on_air_tvseries.dart';
import 'package:ditonton/presentation/tvseries/provider/on_air_tvseries_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvseries_list_provider_test.mocks.dart';

@GenerateMocks([GetOnAirTVSeries])
void main() {
  late MockGetOnAirTVSeries mockGetOnAirTVSeries;
  late OnAirTVSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAirTVSeries = MockGetOnAirTVSeries();
    notifier = OnAirTVSeriesNotifier(mockGetOnAirTVSeries)
      ..addListener(() {
        listenerCallCount++;
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
    when(mockGetOnAirTVSeries.execute())
        .thenAnswer((_) async => Right(tTVSeriesList));
    // act
    notifier.fetchOnAirTVSeries();
    // assert
    expect(notifier.onAirState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully', () async {
    // arrange
    when(mockGetOnAirTVSeries.execute())
        .thenAnswer((_) async => Right(tTVSeriesList));
    // act
    await notifier.fetchOnAirTVSeries();
    // assert
    expect(notifier.onAirTVSeries, tTVSeriesList);
    expect(notifier.onAirState, RequestState.Loaded);
    expect(listenerCallCount, 2);
  });

  test('should change state to error when data is gotten unsuccessfully',
      () async {
    // arrange
    when(mockGetOnAirTVSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchOnAirTVSeries();
    // assert
    expect(notifier.onAirState, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
