import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApiService {
  static const String baseUrl = 'https://stage.app.investifyd.com/api';

  static Map<String, String> get jsonHeader => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'x-app-type': 'WEBAPP',
      };

  // Function to get the authentication token from AuthService
  static Future<Map<String, String>> get tokenHeader async {
    String? authToken = await AuthService.getToken();
    print(authToken);
    return {
      'x-access-token': authToken ?? '',
    };
  }

  // General API request function
  static Future<Map<String, dynamic>> fetchAPI(String endpoint, String method,
      {Map<String, dynamic>? body}) async {
    final url = Uri.parse(baseUrl + endpoint);
    final headers = {...jsonHeader, ...await tokenHeader};

    try {
      final response = await _makeRequest(method, url, body, headers);
      return _checkStatus(response.statusCode, response.body);
    } catch (e) {
      throw 'API request error: $e';
    }
  }

  // API request function for media uploads
  static Future<Map<String, dynamic>> fetchMediaAPI(
      String endpoint, String method,
      {Map<String, dynamic>? body}) async {
    final url = Uri.parse(baseUrl + endpoint);
    final headers = {
      'mimeType': 'multipart/form-data',
      'x-app-type': 'WEBAPP',
      ...await tokenHeader
    };

    try {
      final request = http.MultipartRequest(method, url)
        ..headers.addAll(headers);

      if (method == 'POST' && body != null) {
        request.fields
            .addAll(body.map((key, value) => MapEntry(key, value.toString())));
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      return _checkStatus(response.statusCode, responseBody);
    } catch (e) {
      throw 'Media upload failed: $e';
    }
  }

  // Login API call (without token)
  static Future<Map<String, dynamic>> fetchLoginAPI(
      String endpoint, String method,
      {Map<String, dynamic>? body}) async {
    final url = Uri.parse(baseUrl + endpoint);
    final headers = {...jsonHeader};

    try {
      final response = await _makeRequest(method, url, body, headers);
      return _checkStatus(response.statusCode, response.body);
    } catch (e) {
      throw 'Login failed: $e';
    }
  }

  // Unified method to handle API requests
  static Future<http.Response> _makeRequest(String method, Uri url,
      Map<String, dynamic>? body, Map<String, String> headers) async {
    switch (method.toUpperCase()) {
      case 'POST':
        return await http.post(url, headers: headers, body: json.encode(body));
      case 'GET':
        return await http.get(url, headers: headers);
      case 'PUT':
        return await http.put(url, headers: headers, body: json.encode(body));
      case 'DELETE':
        return await http.delete(url, headers: headers);
      default:
        throw 'Unsupported HTTP method: $method';
    }
  }

  // Response validation and error handling
  static Map<String, dynamic> _checkStatus(
      int statusCode, String responseBody) {
    const successCodes = [200, 201, 202, 204];
    if (successCodes.contains(statusCode)) {
      return json.decode(responseBody);
    } else {
      throw getErrorMessage(responseBody);
    }
  }

  // Extracts a detailed error message from API responses
  static String getErrorMessage(String responseBody) {
    try {
      final error = json.decode(responseBody);
      if (error.containsKey('message')) return error['message'];
      if (error.containsKey('error')) return error['error'];
      if (error.containsKey('data')) return error['data'];
      return 'Unknown error occurred.';
    } catch (e) {
      return 'Invalid error response format.';
    }
  }

  // Logout functionality: Clears token using AuthService
  static Future<void> logout() async {
    await AuthService.clearToken();
    // TODO: Navigate to login screen if using Navigator.
  }
}
