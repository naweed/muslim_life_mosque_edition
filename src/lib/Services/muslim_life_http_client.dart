import 'package:http/http.dart' as http;
import 'package:muslim_life_mosque_edition/Shared/app_constants.dart';

class MuslimLifeHttpClient extends http.BaseClient {
  final http.Client _client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers[AppConstants.Client_ID_Key] = AppConstants.Client_ID;
    request.headers[AppConstants.Client_Secret_Key] = AppConstants.Client_Secret;
    request.headers[AppConstants.Client_Token_Key] = AppConstants.Client_Token;

    return _client.send(request);
  }
}
