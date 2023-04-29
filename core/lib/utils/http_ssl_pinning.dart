import 'package:core/utils/shared.dart';
import 'package:http/http.dart' as http;

class HttpSSLPinning {
  static http.Client? _client;
  static Future<http.Client> get _instance async {
    _client ??= await Shared.createClient();
    return _client!;
  }

  static http.Client get client => _client ?? http.Client();
  static Future<void> init() async {
    _client = await _instance;
  }
}
