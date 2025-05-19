import 'package:http/http.dart' as http;

class MuslimLifeHttpClient extends http.BaseClient {
  final http.Client _client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) => _client.send(request);
}
