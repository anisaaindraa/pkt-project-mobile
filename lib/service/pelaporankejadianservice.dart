import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patroli_app/model/pelaporan_kejadian_model.dart';
import 'package:patroli_app/repository/auth_repository.dart';

class FormulirPelaporanKejadianRepository {
  Future<void> createFormulirPelaporanKejadian({
    required String jenisKejadian,
    required String tanggalWaktuKejadian,
    required String tempatKejadian,
    required String kerugianAkibatKejadian,
    required String penanganan,
    required String keteranganLain,
    required List korban,
    required List pelaku,
  }) async {
    try {
      String baseUrl = "http://127.0.0.1:8000/api/formpelaporankejadian";

      var userId = await AuthRepository().getCurrentUser();

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'users_id': userId.toString(),
          'jenis_kejadian': jenisKejadian,
          'tanggal_kejadian': tanggalWaktuKejadian,
          'tempat_kejadian': tempatKejadian,
          'kerugian_akibat_kejadian': kerugianAkibatKejadian,
          'penanganan': penanganan,
          'keterangan_lain': keteranganLain,
          'korban': korban,
          'pelaku': pelaku,
        }),
      );

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        // return FormulirPelaporanKejadian.fromJson(jsonResponse);
      } else {
        print(
            'Failed to create FormulirPelaporanKejadian. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return null;
      }
    } catch (e) {
      print("Error creating FormulirPelaporanKejadian: $e");
      return null;
    }
  }
}
