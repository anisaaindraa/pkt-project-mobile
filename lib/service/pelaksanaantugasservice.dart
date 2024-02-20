import 'dart:convert';
import 'package:patroli_app/model/pelaksanaan_tugas_model.dart';
import 'package:http/http.dart' as http;

class FormulirPelaksanaanTugasService {
  final String baseUrl;

  FormulirPelaksanaanTugasService(this.baseUrl);

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
        Uri.parse('http://127.0.0.1:8000/api/formpelaksanaantugas'),
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
