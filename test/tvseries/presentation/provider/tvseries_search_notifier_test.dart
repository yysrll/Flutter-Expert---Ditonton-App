import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/data/tvseries/models/tvseries_model.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/search_tvseries.dart';
import 'package:ditonton/presentation/tvseries/provider/tvseries_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvseries_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late TVSeriesSearchNotifier notifier;
  late MockSearchTVSeries mockSearchTVSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTVSeries = MockSearchTVSeries();
    notifier = TVSeriesSearchNotifier(searchTVSeries: mockSearchTVSeries)
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

  final tQuery = 'query';

  group('search tv series', () {
    test('initialState should be Empty', () {
      expect(notifier.state, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      notifier.fetchTVSeriesSearch(tQuery);
      await untilCalled(mockSearchTVSeries.execute(tQuery));
      // assert
      verify(mockSearchTVSeries.execute(tQuery));
    });

    test('should emit Loading when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      notifier.fetchTVSeriesSearch(tQuery);
      // assert
      expect(notifier.state, equals(RequestState.Loading));
    });

    test('should emit Loaded adn change data when is gotten successfully', () async {
      // arrange
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      notifier.fetchTVSeriesSearch(tQuery);
      await untilCalled(mockSearchTVSeries.execute(tQuery));
      // assert
      expect(notifier.state, equals(RequestState.Loaded));
      expect(notifier.searchResult, equals(tTVSeriesList));
      expect(listenerCallCount, 2);
    });

    test('should emit Error when getting data is failed', () async {
      // arrange
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      notifier.fetchTVSeriesSearch(tQuery);
      await untilCalled(mockSearchTVSeries.execute(tQuery));
      // assert
      expect(notifier.state, equals(RequestState.Error));
      expect(notifier.message, equals('Server Failure'));
      expect(listenerCallCount, 2);
    });
  });
}
