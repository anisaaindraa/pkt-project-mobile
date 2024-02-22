import 'package:dio/dio.dart';
import 'package:patroli_app/model/patroli_laut_model.dart';
import 'package:patroli_app/model/pelaporan_kejadian_model.dart';
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

  Future<dynamic> createFormulirPatroliLaut(
    int users_id,
    String tanggal_kejadian,
    String m_shift_id,
    String uraian_hasil,
    String keterangan,
    List<PhotoPatroliLaut> photo_patroli_laut,
  ) async {
    try {
      final response =
          await _dio.post('http://127.0.0.1:8000/api/formpatrolilaut', data: {
        'users_id': users_id,
        'tanggal_kejadian': tanggal_kejadian,
        'm_shift_id': m_shift_id,
        'uraian_hasil': uraian_hasil,
        'keterangan': keterangan,
        'photo_patroli_laut':
            photo_patroli_laut.map((photo) => photo.toJson()).toList(),
      });

      if (response.data != null) {
        // handle success
        print('Formulir Patroli Laut created successfully!');
        return response.data;
      } else {
        // handle failure
        print('Failed to create Formulir Patroli Laut.');
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  // Formulir Pelaporan Kejadian

  Future<dynamic> getFormulirPelaporanKejadian() async {
    try {
      final response = await _dio
          .get('http://127.0.0.1:8000/api/formpelaporankejadian/{id}');
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> createFormulirPelaporanKejadian(
    int users_id,
    String jenis_kejadian,
    String tanggal_waktu_kejadian,
    String tempat_kejadian,
    String kerugian_akibat_kejadian,
    String penanganan,
    String keterangan_lain,
    List korban,
    List pelaku,
  ) async {
    try {
      final response = await _dio
          .post('http://127.0.0.1:8000/api/formpelaporankejadian', data: {
        'users_id': users_id,
        'tanggal_waktu_kejadian': tanggal_waktu_kejadian,
        'tempat_kejadian': tempat_kejadian,
        'kerugian_akibat_kejadian': kerugian_akibat_kejadian,
        'penanganan': penanganan,
        'keterangan_lain': keterangan_lain,
        'korban': korban,
        'pelaku': pelaku,
      });

      if (response.data != null) {
        print("Formulir Pelaporan Kejadian created succesfully");
        return response.data;
      } else {
        print('Failed to create Formulir Pelaporan Kejadian');
        return null;
      }
    } catch (e) {
      throw e;
    }
  }
}
