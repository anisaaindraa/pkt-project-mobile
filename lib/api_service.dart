import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://127.0.0.1:8000/api/';

  // Autentikasi

  Future<dynamic> login(String email, String password) async {
    try {
      final response =
          await _dio.post('http://127.0.0.1:8000/api/login', data: {
        'email': email,
        'password': password,
      });

      // Access and store token (adapt based on API response structure)
      final prefs = await SharedPreferences.getInstance();
      if (response.data['token'] != null) {
        await prefs.setString('jwtToken', response.data['token']);
      } else if (response.data['user']['token'] != null) {
        // Or check another location
        await prefs.setString('jwtToken', response.data['user']['token']);
      } else {
        // Handle missing token error
      }

      return response.data;
    } catch (e) {
      throw e;
    }
  }

  // Formulir Patroli Laut

  Future<dynamic> getFormulirPatroliLaut() async {
    try {
      final response =
          await _dio.get('http://127.0.0.1:8000/api/formpatrolilaut');
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> createFormulirPatroliLaut(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
          'http://127.0.0.1:8000/api/createFormulirPatroliLaut',
          data: data);
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  // Formulir Pelaporan Kejadian

  Future<dynamic> getFormulirPelaporanKejadian() async {
    try {
      final response =
          await _dio.get('http://127.0.0.1:8000/api/formpelaporankejadian');
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> createFormulirPelaporanKejadian(
      Map<String, dynamic> data) async {
    try {
      final response = await _dio
          .post('http://127.0.0.1:8000/api/formpelaporankejadian', data: data);
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  // Formulir Pelaksanaan Tugas

  Future<dynamic> getFormulirPelaksanaanTugas() async {
    try {
      final response =
          await _dio.get('http://127.0.0.1:8000/api/formpelaporankejadian');
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> createFormulirPelaksanaanTugas(
      Map<String, dynamic> data) async {
    try {
      final response = await _dio
          .post('http://127.0.0.1:8000/api/formpelaporankejadian', data: data);
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  // Tambahkan fungsi lain sesuai kebutuhan
}
