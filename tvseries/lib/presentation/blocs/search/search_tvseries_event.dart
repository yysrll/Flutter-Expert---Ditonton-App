part of 'search_tvseries_bloc.dart';

abstract class SearchTVSeriesEvent extends Equatable {
  const SearchTVSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChange extends SearchTVSeriesEvent {
  final String query;

  const OnQueryChange(this.query);

  @override
  List<Object> get props => [query];
}
