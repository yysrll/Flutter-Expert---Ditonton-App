import 'package:ditonton/domain/tvseries/entities/tvseries.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries_detail.dart';

final testTVSeries = TVSeries(
  posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
  popularity: 47.432451,
  id: 31917,
  backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
  voteAverage: 5.04,
  overview: 'Based on the Pretty Little Liars series of young adult novels',
  firstAirDate: '2010-06-08',
  originCountry: ["US"],
  genreIds: [18, 9648],
  originalLanguage: 'en',
  voteCount: 133,
  name: 'Pretty Little Liars',
  originalName: 'Pretty Little Liars',
);

final testTVSeriesList = [testTVSeries];

final testTVSeriesDetail = TVSeriesDetail(
  backdropPath: 'backdropPath',
  episodeRunTime: [1, 2, 3],
  firstAirDate: 'firstAirDate',
  genres: [],
  id: 1,
  inProduction: true,
  languages: ['languages'],
  lastAirDate: 'lastAirDate',
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  seasons: [],
  status: 'status',
  type: 'type',
  voteAverage: 1,
  voteCount: 1,
  tagline: 'tagLine',
);
