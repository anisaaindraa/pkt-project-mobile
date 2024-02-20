// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:patroli_app/model/pelaksanaan_tugas_model.dart';
// import 'package:patroli_app/service/pelaksanaantugasservice.dart';

// class PelaksanaanTugasForm extends StatefulWidget {
//   @override
//   _PelaksanaanTugasFormState createState() => _PelaksanaanTugasFormState();
// }

// class _PelaksanaanTugasFormState extends State<PelaksanaanTugasForm> {
//   TextEditingController _tanggalController = TextEditingController();
//   TextEditingController _keteranganController = TextEditingController();
//   List<WaktuUraianTugas> _waktuUraianTugasList = [];
//   List<InventarisPos> _inventarisPosList = [];

//   // Function to add waktu uraian tugas
//   void _addWaktuUraianTugas(String waktu, String uraianTugas) {
//     setState(() {
//       _waktuUraianTugasList
//           .add(WaktuUraianTugas(waktu: waktu, uraianTugas: uraianTugas));
//     });
//   }

//   // Function to add inventaris pos
//   void _addInventarisPos(
//       int mBarangInventarisId, int jumlah, String keterangan) {
//     setState(() {
//       _inventarisPosList.add(InventarisPos(
//           mBarangInventarisId: mBarangInventarisId,
//           jumlah: jumlah,
//           keterangan: keterangan));
//     });
//   }

//   // Function to submit the form
//   void _submitForm() async {
//     // Define other form fields

//     // Call the service to create the formulir pelaksanaan tugas
//     FormulirPelaksanaanTugasService service =
//         FormulirPelaksanaanTugasService('http://127.0.0.1:8000/api/');
//     FormulirPelaksanaanTugas response =
//         await service.createFormulirPelaksanaanTugas(
//             // Pass the necessary parameters
//             );

//     // Handle the response as needed
//     if (response.success) {
//       // Formulir created successfully, handle accordingly
//       print('Formulir created successfully');
//     } else {
//       // Formulir creation failed, handle accordingly
//       print('Formulir creation failed: ${response.message}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pelaksanaan Tugas Form'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             // Example date picker
//             ElevatedButton(
//               onPressed: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2101),
//                 );
//                 if (pickedDate != null) {
//                   _tanggalController.text = pickedDate.toLocal().toString();
//                 }
//               },
//               child: Text('Pick Date'),
//             ),

//             // Example dropdown
//             // You can fetch the dropdown items from your API and populate them here
//             DropdownButtonFormField<String>(
//               value: 'Select Shift', // Replace with the selected value
//               onChanged: (value) {
//                 // Handle dropdown value change
//               },
//               items: [
//                 DropdownMenuItem<String>(
//                   value: 'Shift 1',
//                   child: Text('Shift 1'),
//                 ),
//                 DropdownMenuItem<String>(
//                   value: 'Shift 2',
//                   child: Text('Shift 2'),
//                 ),
//                 // Add more items as needed
//               ],
//             ),

//             // Add more form fields, buttons, etc.

//             // Example button to add waktu uraian tugas
//             ElevatedButton(
//               onPressed: () {
//                 // Show modal or add waktu uraian tugas directly
//                 // You may use showModalBottomSheet or other modals
//                 _addWaktuUraianTugas('09:00 AM', 'Do something');
//               },
//               child: Text('Add Waktu Uraian Tugas'),
//             ),

//             // Example button to add inventaris pos
//             ElevatedButton(
//               onPressed: () {
//                 // Show modal or add inventaris pos directly
//                 // You may use showModalBottomSheet or other modals
//                 _addInventarisPos(1, 5, 'Some description');
//               },
//               child: Text('Add Inventaris Pos'),
//             ),

//             // Display added waktu uraian tugas
//             Text('Waktu Uraian Tugas: $_waktuUraianTugasList'),

//             // Display added inventaris pos
//             Text('Inventaris Pos: $_inventarisPosList'),

//             // Example keterangan input field
//             TextField(
//               controller: _keteranganController,
//               decoration: InputDecoration(labelText: 'Keterangan'),
//             ),

//             // Example submit button
//             ElevatedButton(
//               onPressed: _submitForm,
//               child: Text('Submit Form'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
