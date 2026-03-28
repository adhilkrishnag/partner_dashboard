import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Create a singleton instance
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  // Create an instance of FlutterSecureStorage
  final _storage = const FlutterSecureStorage(
    webOptions: WebOptions(useSessionStorage: true),
  );

  // Method to store data
  Future<void> storeData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Method to retrieve data
  Future<String?> retrieveData(String key) async {
    return await _storage.read(key: key);
  }

  // Method to delete specific data
  Future<void> deleteData(String key) async {
    await _storage.delete(key: key);
  }

  // Method to delete all stored data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  Future<void> storeAccessToken(String token) async {
    await storeData('accessToken', token);
  }

  Future<String?> get accessToken async {
    return await retrieveData('accessToken');
  }
}
