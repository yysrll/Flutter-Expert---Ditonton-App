import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/search_movies.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc(this.searchMovies) : super(SearchEmpty()) {
    on<OnQueryChange>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());

      final result = await searchMovies.execute(query);
      result.fold(
        (failure) => emit(SearchError(failure.message)),
        (movies) => emit(SearchLoaded(movies)),
      );
    });
  }
}
