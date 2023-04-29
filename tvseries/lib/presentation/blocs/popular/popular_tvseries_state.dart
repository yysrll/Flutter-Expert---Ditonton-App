part of 'popular_tvseries_bloc.dart';

abstract class PopularTVSeriesState extends Equatable {
  const PopularTVSeriesState();

  @override
  List<Object> get props => [];
}

class PopularTVSeriesLoading extends PopularTVSeriesState {}

class PopularTVSeriesLoaded extends PopularTVSeriesState {
  final List<TVSeries> tvSeries;

  const PopularTVSeriesLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class PopularTVSeriesError extends PopularTVSeriesState {
  final String message;

  const PopularTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTVSeriesEmpty extends PopularTVSeriesState {}
