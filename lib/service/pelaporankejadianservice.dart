import 'dart:convert';
import 'package:patroli_app/model/pelaporan_kejadian_model.dart';
import 'package:http/http.dart' as http;

class FormulirPelaporanKejadianService {
  final String baseUrl;
  FormulirPelaporanKejadianService(this.baseUrl);

  Future<FormulirPelaporanKejadian> createFormulirPelaporanKejadian({
    required int usersId,
    required String jenisKejadian,
    required String tanggalKejadian,
    required String waktuKejadian,
    required String tempatKejadian,
    required String kerugianAkibatKejadian,
    required String keteranganLain,
    required List<Korban> korban,
    required List<Pelaku> pelaku,
  }) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/api/formpelaporankejadian'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'users_id': usersId.toString(),
          'jenis_kejadian': jenisKejadian,
          'tanggal_kejadian': tanggalKejadian,
          'waktu_kejadian': waktuKejadian,
          'tempat_kejadian': tempatKejadian,
          'kerugian_akibat_kejadian': kerugianAkibatKejadian,
          'keterangan_lain': keteranganLain,
          'korban': json.encode(
            korban
                .map((korban) => {
                      'nama_korban': korban.namaKorban,
                      'umur_korban': korban.umurKorban.toString(),
                      'pekerjaan_korban': korban.pekerjaanKorban,
                      'alamat_korban': korban.alamatKorban,
                      'no_tlp_korban': korban.noTlpKorban.toString(),
                    })
                .toList(),
          ),
          'pelaku': json.encode(
            pelaku
                .map((pelaku) => {
                      'nama_pelaku': pelaku.namaPelaku,
                      'umur_pelaku': pelaku.umurPelaku.toString(),
                      'pekerjaan_pelaku': pelaku.pekerjaanPelaku,
                      'alamat_pelaku': pelaku.alamatPelaku,
                      'no_tlp_pelaku': pelaku.noTlpPelaku.toString(),
                    })
                .toList(),
          ),
        },
      );

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        return FormulirPelaporanKejadian.fromJson(jsonResponse);
      } else {
        // Handle non-201 status codes, you might want to throw an exception here
        return FormulirPelaporanKejadian(
          success: false,
          message: 'Failed to create Formulir Pelaporan Kejadian',
          data: FormulirPelaporanKejadianData(
            id: 0,
            usersId: 0,
            jenisKejadian: '',
            tanggalKejadian: '',
            waktuKejadian: '',
            tempatKejadian: '',
            kerugianAkibatKejadian: '',
            keteranganLain: '',
            korban: [],
            pelaku: [],
          ),
        );
      }
    } catch (e) {
      // Handle exceptions, you might want to throw an exception here
      return FormulirPelaporanKejadian(
        success: false,
        message: 'An error occurred while creating Formulir Pelaporan Kejadian',
        data: FormulirPelaporanKejadianData(
          id: 0,
          usersId: 0,
          jenisKejadian: '',
          tanggalKejadian: '',
          waktuKejadian: '',
          tempatKejadian: '',
          kerugianAkibatKejadian: '',
          keteranganLain: '',
          korban: [],
          pelaku: [],
        ),
      );
    }
  }
}
