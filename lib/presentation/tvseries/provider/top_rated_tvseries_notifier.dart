import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_top_rated_tvseries.dart';
import 'package:flutter/material.dart';

class TopRatedTVSeriesNotifier extends ChangeNotifier {
  final GetTopRatedTVSeries getTopRatedTVSeries;

  TopRatedTVSeriesNotifier(this.getTopRatedTVSeries);

  var _tvSeries = <TVSeries>[];
  List<TVSeries> get tvSeries => _tvSeries;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTVSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVSeries.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvseriesesData) {
        _state = RequestState.Loaded;
        _tvSeries = tvseriesesData;
        notifyListeners();
      },
    );
  }
}
