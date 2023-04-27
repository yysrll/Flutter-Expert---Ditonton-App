import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_on_air_tvseries.dart';
import 'package:flutter/material.dart';

class OnAirTVSeriesNotifier extends ChangeNotifier {
  final GetOnAirTVSeries getOnAirTVSeries;

  OnAirTVSeriesNotifier(this.getOnAirTVSeries);

  var _onAirTVSeries = <TVSeries>[];
  List<TVSeries> get onAirTVSeries => _onAirTVSeries;

  RequestState _onAirState = RequestState.Empty;
  RequestState get onAirState => _onAirState;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAirTVSeries() async {
    _onAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTVSeries.execute();
    result.fold(
      (failure) {
        _onAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvseriesesData) {
        _onAirState = RequestState.Loaded;
        _onAirTVSeries = tvseriesesData;
        notifyListeners();
      },
    );
  }
}
