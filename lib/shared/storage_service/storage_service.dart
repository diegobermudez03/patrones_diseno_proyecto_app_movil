import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//storage service implemented with an abstraction so it 
//can be easily interchangeble through devices
abstract class StorageService{
  Future<String?> readToken();
  Future<void> writeToken(String token);
}

class MobileSecureStorageService implements StorageService{
  @override
  Future<String?> readToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'auth_token');
  }

  @override
  Future<void> writeToken(String token) async {
    const storage = FlutterSecureStorage();
    storage.write(key: 'auth_token', value: token);
  }
}


class MockStorageService implements StorageService{
  @override
  Future<String?> readToken() async {
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MzE3ODk0NjgsInVzZXJfaWQiOjJ9.a29Se7wSK7tZe-bQp64qRoCZXFPNbTyiFAKcajNAtS8";
  }

  @override
  Future<void> writeToken(String token) async {
  }
}