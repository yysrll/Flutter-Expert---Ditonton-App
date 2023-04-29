part of 'search_tvseries_bloc.dart';

abstract class SearchTVSeriesState extends Equatable {
  const SearchTVSeriesState();

  @override
  List<Object> get props => [];
}

class SearchTVSeriesEmpty extends SearchTVSeriesState {}

class SearchTVSeriesLoading extends SearchTVSeriesState {}

class SearchTVSeriesLoaded extends SearchTVSeriesState {
  final List<TVSeries> tvSeriesList;

  const SearchTVSeriesLoaded(this.tvSeriesList);

  @override
  List<Object> get props => [tvSeriesList];
}

class SearchTVSeriesError extends SearchTVSeriesState {
  final String message;

  const SearchTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
