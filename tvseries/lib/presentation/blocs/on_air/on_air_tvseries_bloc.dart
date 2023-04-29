import 'package:core/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/usecases/get_on_air_tvseries.dart';

part 'on_air_tvseries_state.dart';
part 'on_air_tvseries_event.dart';

class OnAirTVSeriesBloc extends Bloc<OnAirTVSeriesEvent, OnAirTVSeriesState> {
  final GetOnAirTVSeries getOnAirTVSeries;

  OnAirTVSeriesBloc(this.getOnAirTVSeries) : super(OnAirTVSeriesEmpty()) {
    on<FetchOnAirTVSeries>((event, emit) async {
      emit(OnAirTVSeriesLoading());
      final result = await getOnAirTVSeries.execute();

      result.fold(
        (failure) => emit(OnAirTVSeriesError(failure.message)),
        (tvSeries) {
          if (tvSeries.isEmpty) {
            emit(OnAirTVSeriesEmpty());
          } else {
            emit(OnAirTVSeriesLoaded(tvSeries));
          }
        },
      );
    });
  }
}
