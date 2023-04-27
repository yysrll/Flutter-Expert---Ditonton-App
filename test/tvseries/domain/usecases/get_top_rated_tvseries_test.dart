import 'package:core/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/tvseries/usecases/get_top_rated_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTVSeries usecase;
  late MockTVSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTVSeriesRepository();
    usecase = GetTopRatedTVSeries(mockRepository);
  });

  final tTVSeries = <TVSeries>[];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockRepository.getTopRatedTVSeries())
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTVSeries));
  });
}