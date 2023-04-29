import 'package:core/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/usecases/search_tvseries.dart';

part 'search_tvseries_event.dart';
part 'search_tvseries_state.dart';

class SearchTVSeriesBloc
    extends Bloc<SearchTVSeriesEvent, SearchTVSeriesState> {
  final SearchTVSeries searchTVSeries;

  SearchTVSeriesBloc(this.searchTVSeries) : super(SearchTVSeriesEmpty()) {
    on<OnQueryChange>((event, emit) async {
      emit(SearchTVSeriesLoading());
      final result = await searchTVSeries.execute(event.query);
      result.fold(
        (failure) => emit(SearchTVSeriesError(failure.message)),
        (tvSeriesList) => {
          if (tvSeriesList.isEmpty)
            {
              emit(SearchTVSeriesEmpty()),
            }
          else
            {
              emit(SearchTVSeriesLoaded(tvSeriesList)),
            }
        },
      );
    });
  }
}
