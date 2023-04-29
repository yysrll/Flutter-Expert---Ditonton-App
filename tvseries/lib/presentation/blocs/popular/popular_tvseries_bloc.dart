import 'package:core/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/usecases/get_popular_tvseries.dart';

part 'popular_tvseries_event.dart';
part 'popular_tvseries_state.dart';

class PopularTVSeriesBloc
    extends Bloc<PopularTVSeriesEvent, PopularTVSeriesState> {
  final GetPopularTVSeries getPopularTVSeries;

  PopularTVSeriesBloc(this.getPopularTVSeries) : super(PopularTVSeriesEmpty()) {
    on<FetchPopularTVSeries>((event, emit) async {
      emit(PopularTVSeriesLoading());
      final result = await getPopularTVSeries.execute();

      result.fold(
        (failure) => emit(PopularTVSeriesError(failure.message)),
        (tvSeries) {
          if (tvSeries.isEmpty) {
            emit(PopularTVSeriesEmpty());
          } else {
            emit(PopularTVSeriesLoaded(tvSeries));
          }
        },
      );
    });
  }
}
