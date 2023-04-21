import 'package:ditonton/domain/tvseries/repositories/tvseries_repository.dart';

class GetWatchlistTVSeriesStatus {
  final TVSeriesRepository repository;

  GetWatchlistTVSeriesStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
