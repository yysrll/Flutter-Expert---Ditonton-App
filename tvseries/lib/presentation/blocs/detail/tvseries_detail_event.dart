part of 'tvseries_detail_bloc.dart';

abstract class TVSeriesDetailEvent extends Equatable {
  const TVSeriesDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchTVSeriesDetail extends TVSeriesDetailEvent {
  final int id;

  const FetchTVSeriesDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class AddWatchlistTVSeries extends TVSeriesDetailEvent {
  final TVSeriesDetail tvSeriesDetail;

  const AddWatchlistTVSeries(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];
}

class RemoveWatchlistTVSeries extends TVSeriesDetailEvent {
  final TVSeriesDetail tvSeriesDetail;

  const RemoveWatchlistTVSeries(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];
}

class FetchTVSeriesRecommendations extends TVSeriesDetailEvent {
  final int id;

  const FetchTVSeriesRecommendations(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchWatchListStatus extends TVSeriesDetailEvent {
  final int id;

  const FetchWatchListStatus(this.id);

  @override
  List<Object?> get props => [id];
}
