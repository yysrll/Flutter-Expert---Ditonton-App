import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/save_tvseries_watchlist.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTVSeriesWatchlist usecase;
  late MockTVSeriesRepository repository;

  setUp(() {
    repository = MockTVSeriesRepository();
    usecase = SaveTVSeriesWatchlist(repository);
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(repository.saveWatchlist(testTVSeriesDetail))
        .thenAnswer((_) async => const Right('Added to watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetail);
    // assert
    verify(repository.saveWatchlist(testTVSeriesDetail));
    expect(result, const Right('Added to watchlist'));
  });
}
