import 'package:ditonton/data/tvseries/models/tvseries_detail_model.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVSeriesDetailModel = TVSeriesDetailModel(
    backdropPath: 'backdropPath',
    episodeRunTime: [1, 2, 3],
    firstAirDate: 'firstAirDate',
    genres: [],
    id: 1,
    inProduction: true,
    languages: ['en'],
    lastAirDate: 'lastAirDate',
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ['en'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    seasons: [],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTVSeriesDetail = TVSeriesDetail(
    backdropPath: 'backdropPath',
    episodeRunTime: [1, 2, 3],
    firstAirDate: 'firstAirDate',
    genres: [],
    id: 1,
    inProduction: true,
    languages: ['en'],
    lastAirDate: 'lastAirDate',
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ['en'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    seasons: [],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of TV Series Detail entity', () async {
    final result = tTVSeriesDetailModel.toEntity();
    expect(result, tTVSeriesDetail);
  });
}
