import 'package:core/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tvseries.dart';

part 'watchlist_tvseries_event.dart';
part 'watchlist_tvseries_state.dart';

class WatchlistTVSeriesBloc
    extends Bloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState> {
  final GetWatchlistTVSeries getWatchlistTVSeries;

  WatchlistTVSeriesBloc(this.getWatchlistTVSeries)
      : super(WatchlistTVSeriesEmpty()) {
    on<FetchWatchlistTVSeries>((event, emit) async {
      emit(WatchlistTVSeriesLoading());
      final result = await getWatchlistTVSeries.execute();
      result.fold(
        (failure) => emit(WatchlistTVSeriesError(failure.message)),
        (tvSeriesList) {
          if (tvSeriesList.isEmpty) {
            emit(WatchlistTVSeriesEmpty());
          } else {
            emit(WatchlistTVSeriesLoaded(tvSeriesList));
          }
        },
      );
    });
  }
}
