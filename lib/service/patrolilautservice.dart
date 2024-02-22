import 'dart:convert';
import 'package:patroli_app/model/patroli_laut_model.dart';
import 'package:http/http.dart' as http;
import 'package:patroli_app/repository/auth_repository.dart'; // Import your authentication service

class FormulirPatroliLautRepository {
  Future<FormulirPatroliLaut?> createFormulirPatroliLaut(
    String tanggalWaktuKejadian,
    String? mShiftId,
    String uraianHasil,
    String keterangan,
    List<PhotoPatroliLaut> photoPatroliLaut,
    String device,
  ) async {
    String baseUrl = "http://127.0.0.1:8000/api/formpatrolilaut";

    try {
      // Assuming your_auth_service.getCurrentUser() returns the user ID
      var userId = await AuthRepository().getCurrentUser();
      final response = await http.post(
        Uri.parse(baseUrl),
        body: {
          'users_id': userId
              .toString(), // Use the user ID obtained from the authentication service
          'tanggal_waktu_kejadian': tanggalWaktuKejadian,
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
      // print('Error creating FormulirPatroliLaut: $e');
      return null;
    }
  }

  Future<FormulirPatroliLaut?> getData(int id) async {
    String baseUrl = "http://127.0.0.1:8000/api/formpatrolilaut/$id";

    try {
      var response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        return FormulirPatroliLaut.fromJson(body);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching FormulirPatroliLaut: $e');
      return null;
    }
  }
}
