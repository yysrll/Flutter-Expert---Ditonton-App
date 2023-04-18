import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_on_air_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnAirTVSeries usecase;
  late MockTVSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTVSeriesRepository();
    usecase = GetOnAirTVSeries(mockRepository);
  });

  final tTVSeries = <TVSeries>[];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockRepository.getOnAirTVSeries())
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTVSeries));
  });
}