import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patroli_app/formulirpelaporankejadian.dart'; // Sesuaikan dengan path formulirpelaporankejadian.dart
import 'package:patroli_app/model/pelaporan_kejadian_model.dart'; // Sesuaikan dengan path pelaporan_kejadian_model.dart

class KejadianStorePage extends StatefulWidget {
  const KejadianStorePage({Key? key}) : super(key: key);

  @override
  _KejadianStorePageState createState() => _KejadianStorePageState();
}

class _KejadianStorePageState extends State<KejadianStorePage> {
  List<PelaporanKejadianFormData> _pelaporanKejadianForms = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Ganti dengan ID yang sesuai
      int id = 1;

      var response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/formpelaporankejadian/$id"),
      );

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        FormulirPelaporanKejadian data =
            FormulirPelaporanKejadian.fromJson(body);

        setState(() {
          _pelaporanKejadianForms.add(
              PelaporanKejadianFormData.fromFormulirPelaporanKejadian(data));
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching FormulirPelaporanKejadian: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kejadian Store'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _pelaporanKejadianForms.length,
        itemBuilder: (context, index) {
          return KejadianCard(formData: _pelaporanKejadianForms[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigasi ke formulir pelaporan kejadian
          PelaporanKejadianFormData? newForm = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PelaporanKejadianForm(),
            ),
          );

          if (newForm != null) {
            setState(() {
              _pelaporanKejadianForms.add(newForm);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class KejadianCard extends StatelessWidget {
  final PelaporanKejadianFormData formData;

  KejadianCard({required this.formData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jenis Kejadian: ${formData.selectedJenisKejadian}'),
            Text('Tanggal Kejadian: ${formData.selectedTanggalWaktuKejadian}'),
            // Tambahkan data-data lain sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}

class PelaporanKejadianFormData {
  final String selectedJenisKejadian;
  final DateTime selectedTanggalWaktuKejadian;
  final String tempatKejadian;
  final String penanganan;
  final String keterangan;
  final List<Korban> korban;
  final List<Pelaku> pelaku;

  PelaporanKejadianFormData({
    required this.selectedJenisKejadian,
    required this.selectedTanggalWaktuKejadian,
    required this.tempatKejadian,
    required this.penanganan,
    required this.keterangan,
    required this.korban,
    required this.pelaku,
    // Tambahkan parameter dan property lain sesuai kebutuhan
  });

  factory PelaporanKejadianFormData.fromFormulirPelaporanKejadian(
      FormulirPelaporanKejadian data) {
    return PelaporanKejadianFormData(
      selectedJenisKejadian: data.jenis_kejadian,
      selectedTanggalWaktuKejadian: data.tanggal_waktu_kejadian,
      tempatKejadian: data.tempat_kejadian,
      penanganan: data.penanganan,
      keterangan: data.keterangan_lain,
      korban: data.korban,
      pelaku: data.pelaku,
      // Inisialisasi property lain sesuai kebutuhan
    );
  }
}
