import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/tvseries/entities/tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_on_air_tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/get_popular_tvseries.dart';
import 'package:flutter/material.dart';

class TVSeriesListNotifier extends ChangeNotifier {
  var _onAirTVSeries = <TVSeries>[];
  List<TVSeries> get onAirTVSeries => _onAirTVSeries;

  RequestState _onAirState = RequestState.Empty;
  RequestState get onAirState => _onAirState;

  var _popularTVSeries = <TVSeries>[];
  List<TVSeries> get popularTVSeries => _popularTVSeries;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  String _message = '';
  String get message => _message;

  TVSeriesListNotifier({
    required this.getOnAirTVSeries,
    required this.getPopularTVSeries,
  });

  final GetOnAirTVSeries getOnAirTVSeries;
  final GetPopularTVSeries getPopularTVSeries;

  Future<void> fetchOnAirTVSeries() async {
    _onAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTVSeries.execute();
    result.fold(
      (failure) {
        _onAirState = RequestState.Error;
        _message = failure.message;
        print('failed: $_message');
        notifyListeners();
      },
      (tvseriesesData) {
        _onAirState = RequestState.Loaded;
        _onAirTVSeries = tvseriesesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTVSeries() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVSeries.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvseriesesData) {
        _popularState = RequestState.Loaded;
        _popularTVSeries = tvseriesesData;
        notifyListeners();
      },
    );
  }
}
