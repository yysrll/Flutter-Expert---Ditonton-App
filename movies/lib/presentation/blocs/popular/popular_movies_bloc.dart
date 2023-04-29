import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';

part 'popular_movies_state.dart';
part 'popular_movies_event.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc(this.getPopularMovies) : super(PopularMoviesEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());

      final result = await getPopularMovies.execute();
      result.fold(
        (failure) => emit(PopularMoviesError(failure.message)),
        (movies) => {
          if (movies.isNotEmpty)
            emit(PopularMoviesLoaded(movies))
          else
            emit(PopularMoviesEmpty())
        },
      );
    });
  }
}
