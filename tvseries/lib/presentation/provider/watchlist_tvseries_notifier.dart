import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:flutter/material.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tvseries.dart';

class WatchlistTVSeriesNotifier extends ChangeNotifier {
  final GetWatchlistTVSeries getWatchlistTVSeries;

  WatchlistTVSeriesNotifier({required this.getWatchlistTVSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  var _watchlistTVSeries = <TVSeries>[];
  List<TVSeries> get watchlistTVSeries => _watchlistTVSeries;

  Future<void> fetchWatchlistTVSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTVSeries.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _watchlistTVSeries = data;
        notifyListeners();
      },
    );
  }
}
