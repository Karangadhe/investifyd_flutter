import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl =
      'https://stage.app.investifyd.com/api'; // Adjust for your environment

  static Map<String, String> get jsonHeader => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'x-app-type': 'WEBAPP',
      };

  // Function to get the authentication token (from SharedPreferences or wherever it's stored)
  static Future<Map<String, String>> get tokenHeader async {
    final prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');
    return {
      'x-access-token': authToken ?? '', // Provide the token or an empty string
    };
  }

  // General API fetch method for standard JSON requests
  static Future<Map<String, dynamic>> fetchAPI(String endpoint, String method,
      {Map<String, dynamic>? body}) async {
    final url = Uri.parse(baseUrl + endpoint);

    final headers = {...jsonHeader, ...await tokenHeader};
    final options = <String, dynamic>{'headers': headers, 'method': method};

    if (method == 'POST' && body != null) {
      options['body'] = json.encode(body);
    }

    try {
      final response = await _makeRequest(method, url, body, headers);
      return _checkStatus(response.statusCode, response.body);
    } catch (e) {
      throw 'There was an error processing your request, please try again later.';
    }
  }

  // Fetch method for media uploads (multipart/form-data)
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
      throw 'There was an error processing your request, please try again later.';
    }
  }

  // Login API call
  static Future<Map<String, dynamic>> fetchLoginAPI(
      String endpoint, String method,
      {Map<String, dynamic>? body}) async {
    final url = Uri.parse(baseUrl + endpoint);
    final headers = {...jsonHeader};

    try {
      final response = await _makeRequest(method, url, body, headers);
      return _checkStatus(response.statusCode, response.body);
    } catch (e) {
      throw 'There was an error processing your request, please try again later.';
    }
  }

  // Helper method to handle the request (POST, GET, etc.)
  static Future<http.Response> _makeRequest(String method, Uri url,
      Map<String, dynamic>? body, Map<String, String> headers) async {
    if (method == 'POST') {
      return await http.post(url, headers: headers, body: json.encode(body));
    } else if (method == 'GET') {
      return await http.get(url, headers: headers);
    } else {
      throw 'Unsupported method $method';
    }
  }

  // Checks the status code and processes the response
  static Map<String, dynamic> _checkStatus(
      int statusCode, String responseBody) {
    const successCodes = [200, 201, 204, 202];
    if (successCodes.contains(statusCode)) {
      return json.decode(responseBody);
    } else {
      throw 'Failed to load data: $statusCode';
    }
  }

  // Get detailed error message from the response body
  static String getErrorMessage(String responseBody) {
    try {
      final error = json.decode(responseBody);
      if (error.containsKey('data')) {
        return error['data'] ?? '';
      } else if (error.containsKey('error')) {
        return error['error'] ?? '';
      } else if (error.containsKey('message')) {
        return error['message'] ?? '';
      }
      return 'There was an error processing your request, please try again.';
    } catch (e) {
      return 'There was an error processing your request, please try again.';
    }
  }

  // Redirect to login page or handle logout functionality
  static void redirectToLogin() {
    // Clear session or auth token and navigate to login page.
    // If using Navigator or routes, you can handle that here.
  }
}
