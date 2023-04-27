import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:ditonton/domain/tvseries/usecases/search_tvseries.dart';
import 'package:flutter/material.dart';

class TVSeriesSearchNotifier extends ChangeNotifier {
  final SearchTVSeries searchTVSeries;

  TVSeriesSearchNotifier({required this.searchTVSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TVSeries> _searchResult = [];
  List<TVSeries> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVSeriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTVSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
