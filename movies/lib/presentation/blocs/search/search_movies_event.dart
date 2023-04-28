part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChange extends SearchMoviesEvent {
  final String query;

  const OnQueryChange(this.query);

  @override
  List<Object> get props => [query];
}
