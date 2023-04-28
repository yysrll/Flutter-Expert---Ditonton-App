import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/remove_tvseries_watchlist.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTVSeriesWatchlist usecase;
  late MockTVSeriesRepository repository;
  
  setUp(() {
    repository = MockTVSeriesRepository();
    usecase = RemoveTVSeriesWatchlist(repository);
  });

  test('should remove tv series from the repository', () async {
    // arrange
    when(repository.removeFromWatchlist(testTVSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetail);
    // assert
    verify(repository.removeFromWatchlist(testTVSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
