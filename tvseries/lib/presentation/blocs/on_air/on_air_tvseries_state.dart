part of 'on_air_tvseries_bloc.dart';

abstract class OnAirTVSeriesState extends Equatable {
  const OnAirTVSeriesState();

  @override
  List<Object> get props => [];
}

class OnAirTVSeriesLoading extends OnAirTVSeriesState {}

class OnAirTVSeriesLoaded extends OnAirTVSeriesState {
  final List<TVSeries> tvSeries;

  const OnAirTVSeriesLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class OnAirTVSeriesError extends OnAirTVSeriesState {
  final String message;

  const OnAirTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class OnAirTVSeriesEmpty extends OnAirTVSeriesState {}
