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

class FormulirPatroliLautRepository {
  final String baseUrl;

  FormulirPatroliLautRepository(this.baseUrl);
  Future<FormulirPatroliLaut> createFormulirPatroliLaut(
    int usersId,
    String tanggalKejadian,
    int mShiftId,
    String uraianHasil,
    String keterangan,
    List<PhotoPatroliLaut> photoPatroliLaut,
  ) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/formpatrolilaut'),
        body: {
          'users_id': usersId.toString(),
          'tanggal_kejadian': tanggalKejadian,
          'm_shift_id': mShiftId.toString(),
          'uraian_hasil': uraianHasil,
          'keterangan': keterangan,
          'photo_patroli_laut': json.encode(
            photoPatroliLaut
                .map((photo) => {'photo_path': photo.photoPath})
                .toList(),
          ),
        },
      );

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        return FormulirPatroliLaut.fromJson(jsonResponse);
      } else {
        // Handle non-201 status codes, you might want to throw an exception here
        return FormulirPatroliLaut(
          success: false,
          message: 'Failed to create Formulir Patroli Laut',
          data: FormulirPatroliLautData(
            id: 0,
            usersId: 0,
            tanggalKejadian: '',
            mShiftId: 0,
            uraianHasil: '',
            keterangan: '',
            photoPatroliLaut: [],
          ),
        );
      }
    } catch (e) {
      // Handle exceptions, you might want to throw an exception here
      return FormulirPatroliLaut(
        success: false,
        message: 'An error occurred while creating Formulir Patroli Laut',
        data: FormulirPatroliLautData(
          id: 0,
          usersId: 0,
          tanggalKejadian: '',
          mShiftId: 0,
          uraianHasil: '',
          keterangan: '',
          photoPatroliLaut: [],
        ),
      );
    }
  }
}

class FormulirPelaporanKejadianRepository {
  final String baseUrl;

  FormulirPelaporanKejadianRepository(this.baseUrl);

  Future<FormulirPelaporanKejadian> createFormulirPelaporanKejadian(
    int usersId,
    String jenisKejadian,
    String tanggalKejadian,
    String waktuKejadian,
    String tempatKejadian,
    String kerugianAkibatKejadian,
    String keteranganLain,
    List<Korban> korban,
    List<Pelaku> pelaku,
  ) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/formpelaporankejadian'),
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

class FormulirPelaksanaanTugasRepository {
  final String baseUrl;

  FormulirPelaksanaanTugasRepository(this.baseUrl);

  Future<FormulirPelaksanaanTugas> createFormulirPelaksanaanTugas(
    int usersId,
    String tanggalKejadian,
    int mPosId,
    int mSipamId,
    int mShiftId,
    List<WaktuUraianTugas> waktuUraianTugas,
    List<InventarisPos> inventarisPos,
    String keterangan,
  ) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/formpelaksanaantugas'),
        body: {
          'users_id': usersId.toString(),
          'tanggal_kejadian': tanggalKejadian,
          'm_pos_id': mPosId.toString(),
          'm_sipam_id': mSipamId.toString(),
          'm_shift_id': mShiftId.toString(),
          'waktu_uraian_tugas': json.encode(
            waktuUraianTugas
                .map((waktuUraianTugas) => {
                      'waktu': waktuUraianTugas.waktu,
                      'uraian_tugas': waktuUraianTugas.uraianTugas,
                    })
                .toList(),
          ),
          'inventaris_pos': json.encode(
            inventarisPos
                .map((inventarisPos) => {
                      'm_barang_inventaris_id':
                          inventarisPos.mBarangInventarisId.toString(),
                      'jumlah': inventarisPos.jumlah.toString(),
                      'keterangan': inventarisPos.keterangan,
                    })
                .toList(),
          ),
          'keterangan': keterangan,
        },
      );

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        return FormulirPelaksanaanTugas.fromJson(jsonResponse);
      } else {
        // Handle non-201 status codes, you might want to throw an exception here
        return FormulirPelaksanaanTugas(
          success: false,
          message: 'Failed to create Formulir Pelaksanaan Tugas',
          data: FormulirPelaksanaanTugasData(
            id: 0,
            usersId: 0,
            tanggalKejadian: '',
            mPosId: 0,
            mSipamId: 0,
            mShiftId: 0,
            waktuUraianTugas: [],
            inventarisPos: [],
            keterangan: '',
          ),
        );
      }
    } catch (e) {
      // Handle exceptions, you might want to throw an exception here
      return FormulirPelaksanaanTugas(
        success: false,
        message: 'An error occurred while creating Formulir Pelaksanaan Tugas',
        data: FormulirPelaksanaanTugasData(
          id: 0,
          usersId: 0,
          tanggalKejadian: '',
          mPosId: 0,
          mSipamId: 0,
          mShiftId: 0,
          waktuUraianTugas: [],
          inventarisPos: [],
          keterangan: '',
        ),
      );
    }
  }
}
