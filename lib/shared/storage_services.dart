import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String?> readToken() async {
  const storage = FlutterSecureStorage();
  return await storage.read(key: 'auth_token');
}

Future<void> writeToken(String token) async {
  const storage = FlutterSecureStorage();
  storage.write(key: 'auth_token', value: token);
}