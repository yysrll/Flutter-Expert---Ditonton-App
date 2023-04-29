import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_state.dart';
part 'watchlist_movie_event.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc(this.getWatchlistMovies) : super(WatchlistMovieEmpty()) {
    on<FetchWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());

      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(WatchlistMovieError(failure.message)),
        (movies) => {
          if (movies.isEmpty)
            {
              emit(WatchlistMovieEmpty()),
            }
          else
            {
              emit(WatchlistMovieLoaded(movies)),
            }
        },
      );
    });
  }
}
