import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tvseries.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTVSeries usecase;
  late MockTVSeriesRepository repository;

  setUp(() {
    repository = MockTVSeriesRepository();
    usecase = GetWatchlistTVSeries(repository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(repository.getWatchlistTVSeries())
        .thenAnswer((_) async => Right(testTVSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    verify(repository.getWatchlistTVSeries());
    expect(result, Right(testTVSeriesList));
  });
}
