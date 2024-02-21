import 'dart:convert';
import 'package:patroli_app/model/patroli_laut_model.dart';
import 'package:http/http.dart' as http;

class FormulirPatroliLautRepository {
  Future createFormulirPatroliLaut(
    int usersId,
    String tanggalKejadian,
    String? mShiftId,
    String uraianHasil,
    String keterangan,
    List<PhotoPatroliLaut> photoPatroliLaut,
    String device,
  ) async {
    String baseUrl = "http://127.0.0.1:8000/api/formpatrolilaut";

    try {
      final response = await http.post(
        Uri.parse(baseUrl), // Corrected URL
        body: {
          'users_id': usersId.toString(),
          'tanggal_kejadian': tanggalKejadian,
          'm_shift_id': mShiftId ?? '',
          'uraian_hasil': uraianHasil,
          'keterangan': keterangan,
          'photo_patroli_laut': json.encode(
            photoPatroliLaut
                .map((photo) => {'photo_path': photo.photo_path})
                .toList(),
          ),
        },
      );

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        return FormulirPatroliLaut.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
