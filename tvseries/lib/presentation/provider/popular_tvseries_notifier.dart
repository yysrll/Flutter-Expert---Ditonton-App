import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:flutter/material.dart';
import 'package:tvseries/domain/usecases/get_popular_tvseries.dart';

class PopularTVSeriesNotifier extends ChangeNotifier {
  final GetPopularTVSeries getPopularTVSeries;

  PopularTVSeriesNotifier(this.getPopularTVSeries);

  var _popularTVSeries = <TVSeries>[];
  List<TVSeries> get popularTVSeries => _popularTVSeries;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  String _message = '';
  String get message => _message;

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
