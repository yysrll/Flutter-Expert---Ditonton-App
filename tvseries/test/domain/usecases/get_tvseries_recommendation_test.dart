import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_tvseries_recommendations.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';


void main() {
  late GetTVSeriesRecommendations usecase;
  late MockTVSeriesRepository repository;

  setUp(() {
    repository = MockTVSeriesRepository();
    usecase = GetTVSeriesRecommendations(repository);
  });

  const tId = 1;

  test('should get tv series recommendations from the repository', () async {
    // arrange
    when(repository.getTVSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(testTVSeriesList));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTVSeriesList));
  });
}
