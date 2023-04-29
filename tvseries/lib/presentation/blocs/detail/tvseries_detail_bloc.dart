import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/usecases/get_tvseries_detail.dart';
import 'package:tvseries/domain/usecases/get_tvseries_recommendations.dart';
import 'package:tvseries/domain/usecases/get_tvseries_watchlist_status.dart';
import 'package:tvseries/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:tvseries/domain/usecases/save_tvseries_watchlist.dart';

part 'tvseries_detail_event.dart';
part 'tvseries_detail_state.dart';

class TVSeriesDetailBloc
    extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVSeriesDetail getTVSeriesDetail;
  final GetTVSeriesRecommendations getTVSeriesRecommendations;
  final GetWatchlistTVSeriesStatus getWatchListStatus;
  final SaveTVSeriesWatchlist saveWatchlistTVSeries;
  final RemoveTVSeriesWatchlist removeWatchlistTVSeries;

  TVSeriesDetailBloc({
    required this.getTVSeriesDetail,
    required this.getTVSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlistTVSeries,
    required this.removeWatchlistTVSeries,
  }) : super(TVSeriesDetailState.initial()) {
    on<FetchTVSeriesDetail>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));
      final result = await getTVSeriesDetail.execute(event.id);

      result.fold((failure) {
        emit(
          state.copyWith(
            state: RequestState.Error,
            message: failure.message,
          ),
        );
      }, (tvSeriesDetail) {
        emit(
          state.copyWith(
            state: RequestState.Loaded,
            tvSeriesDetail: tvSeriesDetail,
          ),
        );
        add(FetchTVSeriesRecommendations(tvSeriesDetail.id));
      });
    });

    on<FetchTVSeriesRecommendations>((event, emit) async {
      emit(state.copyWith(tvSeriesRecommendationState: RequestState.Loading));
      final result = await getTVSeriesRecommendations.execute(event.id);

      result.fold((failure) {
        emit(
          state.copyWith(
            tvSeriesRecommendationState: RequestState.Error,
            message: failure.message,
          ),
        );
      }, (tvSeriesRecommendations) {
        emit(
          state.copyWith(
            tvSeriesRecommendationState: RequestState.Loaded,
            tvSeriesRecommendation: tvSeriesRecommendations,
          ),
        );
      });
    });

    on<AddWatchlistTVSeries>((event, emit) async {
      final result = await saveWatchlistTVSeries.execute(event.tvSeriesDetail);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              watchlistMessage: failure.message,
            ),
          );
        },
        (message) {
          emit(
            state.copyWith(
              watchlistMessage: message,
            ),
          );
        },
      );
      add(FetchWatchListStatus(event.tvSeriesDetail.id));
    });

    on<RemoveWatchlistTVSeries>((event, emit) async {
      final result =
          await removeWatchlistTVSeries.execute(event.tvSeriesDetail);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              watchlistMessage: failure.message,
            ),
          );
        },
        (message) {
          emit(
            state.copyWith(
              watchlistMessage: message,
            ),
          );
        },
      );
      add(FetchWatchListStatus(event.tvSeriesDetail.id));
    });

    on<FetchWatchListStatus>((event, emit) async {
      final status = await getWatchListStatus.execute(event.id);
      emit(
        state.copyWith(
          isAddedToWatchlist: status,
        ),
      );
    });
  }
}
