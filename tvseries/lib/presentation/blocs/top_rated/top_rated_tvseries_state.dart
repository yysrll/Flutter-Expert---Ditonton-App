part of 'top_rated_tvseries_bloc.dart';

abstract class TopRatedTVSeriesState extends Equatable {
  const TopRatedTVSeriesState();

  @override
  List<Object> get props => [];
}

class TopRatedTVSeriesLoading extends TopRatedTVSeriesState {}

class TopRatedTVSeriesLoaded extends TopRatedTVSeriesState {
  final List<TVSeries> tvSeries;

  const TopRatedTVSeriesLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TopRatedTVSeriesError extends TopRatedTVSeriesState {
  final String message;

  const TopRatedTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTVSeriesEmpty extends TopRatedTVSeriesState {}
