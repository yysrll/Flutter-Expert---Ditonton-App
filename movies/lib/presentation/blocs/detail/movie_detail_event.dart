part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  const FetchMovieDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class AddWatchlistMovie extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const AddWatchlistMovie(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class RemoveWatchlistMovie extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const RemoveWatchlistMovie(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class FetchMovieRecommendations extends MovieDetailEvent {
  final int id;

  const FetchMovieRecommendations(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchWatchListStatus extends MovieDetailEvent {
  final int id;

  const FetchWatchListStatus(this.id);

  @override
  List<Object?> get props => [id];
}
