import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/tvseries/usecases/get_tvseries_detail.dart';
import 'package:ditonton/presentation/tvseries/provider/tvseries_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object.dart';
import 'tvseries_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTVSeriesDetail])
void main() {
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late TVSeriesDetailNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    notifier = TVSeriesDetailNotifier(getTVSeriesDetail: mockGetTVSeriesDetail)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tId = 1;

  group('get TV Series Detail', () {
    test('should get data from the use case', () async {
      // arrange
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVSeriesDetail));
      // act
      await notifier.fetchTVSeriesDetail(tId);
      await untilCalled(mockGetTVSeriesDetail.execute(tId));
      // assert
      verify(mockGetTVSeriesDetail.execute(tId));
    });

    test('should change state to Loading when usecase is called',
        () async {
      // arrange
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVSeriesDetail));
      // act
      notifier.fetchTVSeriesDetail(tId);
      // assert
      expect(notifier.tvSeriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change TV Series when data is gotten successfully', () async {
      // arrange
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVSeriesDetail));
      // act
      await notifier.fetchTVSeriesDetail(tId);
      // assert
      expect(notifier.tvSeriesState, RequestState.Loaded);
      expect(notifier.tvSeries, testTVSeriesDetail);
      expect(listenerCallCount, 2);
    });
    
  });
}
