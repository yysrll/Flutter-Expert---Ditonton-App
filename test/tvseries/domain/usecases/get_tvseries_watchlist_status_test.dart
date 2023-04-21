import 'package:ditonton/domain/tvseries/usecases/get_tvseries_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTVSeriesStatus usecase;
  late MockTVSeriesRepository repository;

  setUp(() {
    repository = MockTVSeriesRepository();
    usecase = GetWatchlistTVSeriesStatus(repository);
  });

  test('should get tv series watchlist status from the repository', () async {
    // arrange
    when(repository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    verify(repository.isAddedToWatchlist(1));
    expect(result, true);
  });
}
