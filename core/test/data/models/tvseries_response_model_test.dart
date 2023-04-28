import 'dart:convert';
import 'package:core/data/models/tvseries_model.dart';
import 'package:core/data/models/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../json_reader.dart';

void main() {
  const tTVSeriesModel = TVSeriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  const tTVSeriesResponseModel =
      TVSeriesResponse(tvSeriesList: <TVSeriesModel>[tTVSeriesModel]);

  group('from Json', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(readJson('dummy_data/tvseries/on_air.json'));
      // act
      final result = TVSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVSeriesResponseModel);
    });
  });

  group('to Json', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "backdropPath",
            "first_air_date": "firstAirDate",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "name": "name",
            "origin_country": ["originCountry"],
            "original_language": "originalLanguage",
            "original_name": "originalName",
            "overview": "overview",
            "popularity": 1,
            "poster_path": "posterPath",
            "vote_average": 1,
            "vote_count": 1
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
