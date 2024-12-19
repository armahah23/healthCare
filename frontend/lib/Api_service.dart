import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api'; // For Android emulator

  static Future<Map<String, dynamic>> signup(
      String fullname, String email, String password, String confirmPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/createuser'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'fullname': fullname,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        }),
      );

      return json.decode(response.body);
    } catch (e) {
      throw Exception('Failed to signup: $e');
    }
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return responseData;
      } else {
        throw responseData['message'] ?? 'Login failed';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}