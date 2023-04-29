part of 'tvseries_detail_bloc.dart';

class TVSeriesDetailState extends Equatable {
  final TVSeriesDetail? tvSeriesDetail;
  final RequestState state;
  final List<TVSeries> tvSeriesRecommendation;
  final RequestState tvSeriesRecommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const TVSeriesDetailState({
    required this.tvSeriesDetail,
    required this.state,
    required this.tvSeriesRecommendation,
    required this.tvSeriesRecommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  factory TVSeriesDetailState.initial() {
    return const TVSeriesDetailState(
      tvSeriesDetail: null,
      state: RequestState.Empty,
      tvSeriesRecommendation: [],
      tvSeriesRecommendationState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  TVSeriesDetailState copyWith({
    TVSeriesDetail? tvSeriesDetail,
    RequestState? state,
    List<TVSeries>? tvSeriesRecommendation,
    RequestState? tvSeriesRecommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return TVSeriesDetailState(
      tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
      state: state ?? this.state,
      tvSeriesRecommendation:
          tvSeriesRecommendation ?? this.tvSeriesRecommendation,
      tvSeriesRecommendationState:
          tvSeriesRecommendationState ?? this.tvSeriesRecommendationState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  @override
  List<Object?> get props => [
        tvSeriesDetail,
        state,
        tvSeriesRecommendation,
        tvSeriesRecommendationState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}
