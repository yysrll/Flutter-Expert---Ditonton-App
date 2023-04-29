import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlistMovie;
  final RemoveWatchlist removeWatchlistMovie;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlistMovie,
    required this.removeWatchlistMovie,
  }) : super(MovieDetailState.initial()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));
      final result = await getMovieDetail.execute(event.id);

      result.fold((failure) {
        emit(
          state.copyWith(
            state: RequestState.Error,
            message: failure.message,
          ),
        );
      }, (movieDetail) {
        emit(
          state.copyWith(
            state: RequestState.Loaded,
            movieDetail: movieDetail,
          ),
        );
        add(FetchMovieRecommendations(movieDetail.id));
      });
    });

    on<FetchMovieRecommendations>((event, emit) async {
      emit(state.copyWith(movieRecommendationState: RequestState.Loading));
      final result = await getMovieRecommendations.execute(event.id);

      result.fold((failure) {
        emit(
          state.copyWith(
            movieRecommendationState: RequestState.Error,
            movieRecommendation: [],
          ),
        );
      }, (movieRecommendation) {
        emit(
          state.copyWith(
            movieRecommendationState: RequestState.Loaded,
            movieRecommendation: movieRecommendation,
          ),
        );
      });
    });

    on<FetchWatchListStatus>((event, emit) async {
      final status = await getWatchListStatus.execute(event.id);
      emit(
        state.copyWith(
          isAddedToWatchlist: status,
        ),
      );
    });

    on<AddWatchlistMovie>((event, emit) async {
      final result = await saveWatchlistMovie.execute(event.movieDetail);

      result.fold((failure) {
        emit(
          state.copyWith(
            watchlistMessage: failure.message,
          ),
        );
      }, (message) {
        emit(
          state.copyWith(
            watchlistMessage: message,
          ),
        );
      });
      add(FetchWatchListStatus(event.movieDetail.id));
    });

    on<RemoveWatchlistMovie>((event, emit) async {
      final result = await removeWatchlistMovie.execute(event.movieDetail);

      result.fold((failure) {
        emit(
          state.copyWith(
            watchlistMessage: failure.message,
          ),
        );
      }, (message) {
        emit(
          state.copyWith(
            watchlistMessage: message,
          ),
        );
      });

      add(FetchWatchListStatus(event.movieDetail.id));
    });
  }
}
