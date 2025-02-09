// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class AuthService {
//   static final FlutterSecureStorage _storage = const FlutterSecureStorage();
//   static final ValueNotifier<bool> authNotifier = ValueNotifier(false);

//   /// **Check if the user is logged in**
//   static Future<bool> isLoggedIn() async {
//     final String? token = await _storage.read(key: 'authToken');
//     final bool loggedIn = token != null;
//     authNotifier.value = loggedIn;
//     return loggedIn;
//   }

//   /// **Save token securely and notify listeners**
//   static Future<void> login(String token) async {
//     await _storage.write(key: 'authToken', value: token);
//     authNotifier.value = true;
//   }

//   /// **Remove token and notify listeners**
//   static Future<void> logout() async {
//     await _storage.delete(key: 'authToken');
//     authNotifier.value = false;
//   }

//   /// **Get the stored token**
//   static Future<String?> getToken() async {
//     return await _storage.read(key: 'authToken');
//   }
// }
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    String? token = await _storage.read(key: 'authToken');
    return token != null; // If token exists, user is logged in
  }

  // Save token on login
  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'authToken', value: token);
  }

  // Retrieve token securely
  static Future<String?> getToken() async {
    return await _storage.read(key: 'authToken');
  }

  // Clear token on logout
  static Future<void> clearToken() async {
    await _storage.delete(key: 'authToken');
  }
}
