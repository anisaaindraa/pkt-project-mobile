import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patroli_app/model/pelaporan_kejadian_model.dart';

class FormulirPelaporanKejadianRepository {
  Future<FormulirPelaporanKejadian?> createFormulirPelaporanKejadian({
    required int usersId,
    required String jenisKejadian,
    required String tanggalKejadian,
    required String waktuKejadian,
    required String tempatKejadian,
    required String kerugianAkibatKejadian,
    required String penanganan,
    required String keteranganLain,
    required List<Korban> korban,
    required List<Pelaku> pelaku,
  }) async {
    try {
      String baseUrl = "http://127.0.0.1:8000/api/formpelaporankejadian";

      final response = await http.post(
        Uri.parse(baseUrl),
        body: {
          'users_id': usersId.toString(),
          'jenis_kejadian': jenisKejadian,
          'tanggal_kejadian': tanggalKejadian,
          'waktu_kejadian': waktuKejadian,
          'tempat_kejadian': tempatKejadian,
          'kerugian_akibat_kejadian': kerugianAkibatKejadian,
          'penanganan': penanganan,
          'keterangan_lain': keteranganLain,
          'korban': json.encode(
            korban
                .map((korban) => {
                      'nama_korban': korban.nama_korban,
                      'umur_korban': korban.umur_korban.toString(),
                      'pekerjaan_korban': korban.pekerjaan_korban,
                      'alamat_korban': korban.alamat_korban,
                      'no_tlp_korban': korban.no_tlp_korban.toString(),
                    })
                .toList(),
          ),
          'pelaku': json.encode(
            pelaku
                .map((pelaku) => {
                      'nama_pelaku': pelaku.nama_pelaku,
                      'umur_pelaku': pelaku.umur_pelaku.toString(),
                      'pekerjaan_pelaku': pelaku.pekerjaan_pelaku,
                      'alamat_pelaku': pelaku.alamat_pelaku,
                      'no_tlp_pelaku': pelaku.no_tlp_pelaku.toString(),
                    })
                .toList(),
          ),
        },
      );

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        return FormulirPelaporanKejadian.fromJson(jsonResponse);
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
