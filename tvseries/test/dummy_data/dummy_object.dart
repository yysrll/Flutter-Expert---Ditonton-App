
import 'package:core/data/models/tvseries_table.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';

final testTVSeries = TVSeries(
  posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
  popularity: 47.432451,
  id: 31917,
  backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
  voteAverage: 5.04,
  overview: 'Based on the Pretty Little Liars series of young adult novels',
  firstAirDate: '2010-06-08',
  originCountry: const ["US"],
  genreIds: const [18, 9648],
  originalLanguage: 'en',
  voteCount: 133,
  name: 'Pretty Little Liars',
  originalName: 'Pretty Little Liars',
);

final testTVSeriesList = [testTVSeries];

const testTVSeriesDetail = TVSeriesDetail(
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

final testWatchlistTVSeries = TVSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTVSeriesTable = TVSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
