import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/tvseries/usecases/search_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTVSeries usecase;
  late MockTVSeriesRepository repository;

  setUp(() {
    repository = MockTVSeriesRepository();
    usecase = SearchTVSeries(repository);
  });

  final tQuery = 'query';

  test('should get tv series searching result from the repository', () async {
    // arrange
    when(repository.searchTVSeries(tQuery))
        .thenAnswer((_) async => Right(testTVSeriesList));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(testTVSeriesList));
  });
}
