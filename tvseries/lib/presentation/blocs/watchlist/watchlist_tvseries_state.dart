part of 'watchlist_tvseries_bloc.dart';

abstract class WatchlistTVSeriesState extends Equatable {
  const WatchlistTVSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesLoading extends WatchlistTVSeriesState {}

class WatchlistTVSeriesLoaded extends WatchlistTVSeriesState {
  final List<TVSeries> tvSeriesList;

  const WatchlistTVSeriesLoaded(this.tvSeriesList);

  @override
  List<Object> get props => [tvSeriesList];
}

class WatchlistTVSeriesError extends WatchlistTVSeriesState {
  final String message;

  const WatchlistTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTVSeriesEmpty extends WatchlistTVSeriesState {}
