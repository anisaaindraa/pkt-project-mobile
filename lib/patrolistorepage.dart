import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:patroli_app/formulirpatrolilaut.dart';
import 'package:patroli_app/model/patroli_laut_model.dart';
import 'package:http/http.dart' as http;

class PatroliStorePage extends StatefulWidget {
  const PatroliStorePage({Key? key}) : super(key: key);

  @override
  _PatroliStorePageState createState() => _PatroliStorePageState();
}

class _PatroliStorePageState extends State<PatroliStorePage> {
  List<PatroliFormData> _patroliForms = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      int id = 1; // Replace with your actual ID or logic
      var response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/formpatrolilaut/$id"),
      );

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        FormulirPatroliLaut data = FormulirPatroliLaut.fromJson(body);
        setState(() {
          _patroliForms.add(PatroliFormData.fromFormulirPatroliLaut(data));
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching FormulirPatroliLaut: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patroli Store'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _patroliForms.length,
        itemBuilder: (context, index) {
          return PatroliCard(formData: _patroliForms[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          PatroliFormData? newForm = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormulirPatroliLautPage(),
            ),
          );

          if (newForm != null) {
            setState(() {
              _patroliForms.add(newForm);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PatroliCard extends StatelessWidget {
  final PatroliFormData formData;

  PatroliCard({required this.formData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('M Shift: ${formData.mShift}'),
            Text('Tanggal Kejadian: ${formData.tanggalKejadian}'),
            Text('Uraian Hasil Patroli: ${formData.uraianHasil}'),
            Text('Keterangan: ${formData.keterangan}'),
            Text(
                'Photo Patroli Laut: ${formData.photoPatroliLaut.map((photo) => photo.photo_path).join(", ")}'),
          ],
        ),
      ),
    );
  }
}

class PatroliFormData {
  final int mShift;
  final DateTime tanggalKejadian;
  final String uraianHasil;
  final String keterangan;
  final List<PhotoPatroliLaut> photoPatroliLaut;

  PatroliFormData({
    required this.mShift,
    required this.tanggalKejadian,
    required this.uraianHasil,
    required this.keterangan,
    required this.photoPatroliLaut,
  });

  factory PatroliFormData.fromFormulirPatroliLaut(FormulirPatroliLaut data) {
    return PatroliFormData(
      mShift: data.m_shift_id, // Replace with the actual property name
      tanggalKejadian:
          DateTime.parse(data.tanggal_kejadian), // Convert to DateTime
      uraianHasil: data.uraian_hasil,
      keterangan: data.keterangan,
      photoPatroliLaut: data.photo_patroli_laut,
    );
  }
}
