import 'package:core/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tvseries.dart';

part 'top_rated_tvseries_event.dart';
part 'top_rated_tvseries_state.dart';

class TopRatedTVSeriesBloc
    extends Bloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState> {
  final GetTopRatedTVSeries getTopRatedTVSeries;

  TopRatedTVSeriesBloc(this.getTopRatedTVSeries)
      : super(TopRatedTVSeriesEmpty()) {
    on<FetchTopRatedTVSeries>((event, emit) async {
      emit(TopRatedTVSeriesLoading());
      final result = await getTopRatedTVSeries.execute();
      result.fold(
        (failure) => emit(TopRatedTVSeriesError(failure.message)),
        (tvseries) => {
          if (tvseries.isNotEmpty)
            emit(TopRatedTVSeriesLoaded(tvseries))
          else
            emit(TopRatedTVSeriesEmpty())
        },
      );
    });
  }
}
