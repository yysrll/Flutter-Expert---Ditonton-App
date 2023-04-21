import 'package:ditonton/data/tvseries/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/data/tvseries/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/domain/tvseries/repositories/tvseries_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TVSeriesRepository,
  TVSeriesRemoteDataSource,
  TVSeriesLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
