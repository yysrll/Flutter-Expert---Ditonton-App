part of 'search_movies_bloc.dart';

abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object?> get props => [];
}

class SearchEmpty extends SearchMoviesState {}

class SearchLoading extends SearchMoviesState {}

class SearchError extends SearchMoviesState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchLoaded extends SearchMoviesState {
  final List<Movie> movies;

  const SearchLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}
