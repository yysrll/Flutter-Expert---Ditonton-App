import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/data/datasources/tvseries_remote_data_source.dart';
import 'package:core/data/models/tvseries_detail_model.dart';
import 'package:core/data/models/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  // ignore: constant_identifier_names
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  // ignore: constant_identifier_names
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() => {
        mockHttpClient = MockHttpClient(),
        dataSource = TVSeriesRemoteDataSourceImpl(client: mockHttpClient)
      });

  group('get On Air TV Series', () {
    final tTVSeriesList = TVSeriesResponse.fromJson(
            jsonDecode(readJson('dummy_data/tvseries/on_air.json')))
        .tvSeriesList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tvseries/on_air.json'), 200));
      // act
      final result = await dataSource.getOnAirTVSeries();
      // assert
      expect(result, equals(tTVSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnAirTVSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TV Series', () {
    final tTVSeriesList = TVSeriesResponse.fromJson(
            jsonDecode(readJson('dummy_data/tvseries/popular.json')))
        .tvSeriesList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tvseries/popular.json'), 200));
      // act
      final result = await dataSource.getPopularTVSeries();
      // assert
      expect(result, equals(tTVSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTVSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TV Series', () {
    final tTVSeriesList = TVSeriesResponse.fromJson(
            jsonDecode(readJson('dummy_data/tvseries/top_rated.json')))
        .tvSeriesList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvseries/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTVSeries();
      // assert
      expect(result, equals(tTVSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTVSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TV Series detail', () {
    final tTVSeriesDetail = TVSeriesDetailModel.fromJson(
        jsonDecode(readJson('dummy_data/tvseries/tvseries_detail.json')));

    test('should return list of TV Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/${tTVSeriesDetail.id}?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvseries/tvseries_detail.json'), 200));
      // act
      final result = await dataSource.getTVSeriesDetail(tTVSeriesDetail.id);
      // assert
      expect(result, equals(tTVSeriesDetail));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/${tTVSeriesDetail.id}?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVSeriesDetail(tTVSeriesDetail.id);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TV Series Recommendations', () {
    final tTVSeriesList = TVSeriesResponse.fromJson(jsonDecode(
            readJson('dummy_data/tvseries/tvseries_recommendation.json')))
        .tvSeriesList;
    const tId = 1;

    test('should return list of TV Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvseries/tvseries_recommendation.json'),
              200));
      // act
      final result = await dataSource.getTVSeriesRecommendations(tId);
      // assert
      expect(result, equals(tTVSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search TV Series', () {
    final tTVSeriesList = TVSeriesResponse.fromJson(
            jsonDecode(readJson('dummy_data/tvseries/search_tvseries.json')))
        .tvSeriesList;
    const tQuery = 'query';

    test('should return list of TV Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvseries/search_tvseries.json'), 200));
      // act
      final result = await dataSource.searchTVSeries(tQuery);
      // assert
      expect(result, equals(tTVSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTVSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
