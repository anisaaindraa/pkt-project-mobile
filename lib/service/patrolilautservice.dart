// import 'dart:convert';
// import 'package:patroli_app/model/patroli_laut_model.dart';
// import 'package:http/http.dart' as http;

// class FormulirPatroliLautService {
//   final String baseUrl;
//   FormulirPatroliLautService(this.baseUrl);

//   Future<FormulirPatroliLaut> createFormulirPatroliLaut(
//    required int usersId,
//    required String tanggalKejadian,
//    required int mShiftId,
//    required String uraianHasil,
//    required String keterangan,
//     List<PhotoPatroliLaut> photoPatroliLaut,
//   ) async {
//     try {
//       final response = await http.post(
//         Uri.parse('/api/formpatrolilaut'),
//         body: {
//           'users_id': usersId.toString(),
//           'tanggal_kejadian': tanggalKejadian,
//           'm_shift_id': mShiftId.toString(),
//           'uraian_hasil': uraianHasil,
//           'keterangan': keterangan,
//           'photo_patroli_laut': json.encode(
//             photoPatroliLaut
//                 .map((photo) => {'photo_path': photo.photo_path})
//                 .toList(),
//           ),
//         },
//       );

//       if (response.statusCode == 201) {
//         var jsonResponse = json.decode(response.body);
//         return FormulirPatroliLaut.fromJson(jsonResponse);
//       } else {
//         // Handle non-201 status codes, you might want to throw an exception here
//         return FormulirPatroliLaut(
//           success: false,
//           message: 'Failed to create Formulir Patroli Laut',
//           data: FormulirPatroliLautData(
//             users_id: 0,
//             tanggal_kejadian: '',
//             m_shift_id: 0,
//             uraian_hasil: '',
//             keterangan: '',
//             photo_patroli_laut: [],
//           ),
//         );
//       }
//     } catch (e) {
//       // Handle exceptions, you might want to throw an exception here
//       return FormulirPatroliLaut(
//         success: false,
//         message: 'An error occurred while creating Formulir Patroli Laut',
//         data: FormulirPatroliLautData(
//           users_id: 0,
//           tanggal_kejadian: '',
//           m_shift_id: 0,
//           uraian_hasil: '',
//           keterangan: '',
//           photo_patroli_laut: [],
//         ),
//       );
//     }
//   }
// }
