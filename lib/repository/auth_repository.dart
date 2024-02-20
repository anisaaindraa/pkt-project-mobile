import 'dart:convert'; // Import the 'dart:convert' library for json.decode
import 'package:http/http.dart' as http;
import 'package:patroli_app/model/data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future loginUser(String _email, String _password, String device) async {
    String baseUrl = "http://127.0.0.1:8000/api/login";

    try {
      // Use Uri.parse to convert the baseUrl to Uri type
      var response = await http.post(
        Uri.parse(baseUrl),
        body: {'email': _email, 'password': _password, 'device_name': device},
      );

      // Check the status code before decoding the response
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return LoginAuth.fromJson(jsonResponse);
      } else {
        // Handle non-200 status codes, you might want to throw an exception here
        return null;
      }
    } catch (e) {
      // Handle exceptions, you might want to throw an exception here
      return null;
    }
  }

  Future<User?> getData(String token) async {
    String baseUrl = "http://127.0.0.1:8000/api/example";
    try {
      var response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      // Process the response as needed
      if (response.statusCode == 200) {
        // Successful response, you can handle the data here
        var body = json.decode(response.body);
        return User.fromJson(body);
      } else {
        // Handle non-200 status codes, if needed
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      return null;
    }
  }

  Future<String?> hasToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    final String? token = local.getString("token_sanctum");
    return token;
  }

  Future<void> setLocalToken(String token) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString('token_sanctum', token);
  }

  Future<void> unsetLocalToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.remove('token_sanctum');
  }
}
