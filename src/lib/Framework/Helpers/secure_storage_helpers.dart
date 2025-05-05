import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelpers {
  static Future<bool> checkKeyExists(FlutterSecureStorage secureStorage, String key) async =>
      await secureStorage.containsKey(key: key);

  static Future<String?> readKeyValue(FlutterSecureStorage secureStorage, String key) async =>
      await secureStorage.read(key: key);

  static Future<void> writeKeyValue(FlutterSecureStorage secureStorage, String key, Object value) async =>
      await secureStorage.write(key: key, value: value.toString());
}
