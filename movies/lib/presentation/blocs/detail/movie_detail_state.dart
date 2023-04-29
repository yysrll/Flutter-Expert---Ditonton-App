part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final RequestState state;
  final List<Movie> movieRecommendation;
  final RequestState movieRecommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const MovieDetailState({
    required this.movieDetail,
    required this.state,
    required this.movieRecommendation,
    required this.movieRecommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  factory MovieDetailState.initial() {
    return const MovieDetailState(
      movieDetail: null,
      state: RequestState.Empty,
      movieRecommendation: [],
      movieRecommendationState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    RequestState? state,
    List<Movie>? movieRecommendation,
    RequestState? movieRecommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      state: state ?? this.state,
      movieRecommendation: movieRecommendation ?? this.movieRecommendation,
      movieRecommendationState:
          movieRecommendationState ?? this.movieRecommendationState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  @override
  List<Object?> get props => [
        movieDetail,
        state,
        movieRecommendation,
        movieRecommendationState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}
