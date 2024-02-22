import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patroli_app/model/pelaporan_kejadian_model.dart';
import 'package:patroli_app/service/pelaporankejadianservice.dart';

class PelaporanKejadianForm extends StatefulWidget {
  @override
  _PelaporanKejadianFormState createState() => _PelaporanKejadianFormState();
}

class _PelaporanKejadianFormState extends State<PelaporanKejadianForm> {
  final _formKey = GlobalKey<FormState>();

  String selectedJenisKejadian = '';
  DateTime? selectedTanggalWaktuKejadian;
  TextEditingController tempatController = TextEditingController();
  TextEditingController uraianController = TextEditingController();
  TextEditingController kerugianController = TextEditingController();
  TextEditingController penangananController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  List KorbanController = [];
  List PelakuController = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Pelaporan Kejadian'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  value: selectedJenisKejadian,
                  onChanged: (String? value) {
                    setState(() {
                      selectedJenisKejadian = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: '',
                      child: Text('Pilih Jenis Kejadian'),
                    ),
                    DropdownMenuItem(
                      value: 'kejahatan',
                      child: Text('Kejahatan'),
                    ),
                    DropdownMenuItem(
                      value: 'pelanggaran',
                      child: Text('Pelanggaran'),
                    ),
                    DropdownMenuItem(
                      value: 'kecelakaan',
                      child: Text('Kecelakaan'),
                    ),
                    DropdownMenuItem(
                      value: 'lain-lain',
                      child: Text('Lain-lain'),
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Jenis Kejadian',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih Jenis Kejadian';
                    }
                    return null;
                  },
                ),
                if (selectedJenisKejadian == 'lain-lain')
                  TextFormField(
                    controller: uraianController,
                    decoration: InputDecoration(
                      labelText: 'Jenis Kejadian Lainnya',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                SizedBox(height: 30),
                DateTimeField(
                  format: DateFormat("yyyy-MM-dd HH:mm:ss"),
                  onChanged: (date) {
                    selectedTanggalWaktuKejadian = date;
                  },
                  decoration: InputDecoration(
                    labelText: 'Tanggal dan Waktu Kejadian',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white, // White background color
                  ),
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now(),
                        ),
                      );
                      return DateTimeField.combine(date, time);
                    } else {
                      return currentValue;
                    }
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: tempatController,
                  decoration: InputDecoration(
                    labelText: 'Tempat Kejadian',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Tempat Kejadian';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showKorbanDialog(context);
                      },
                      child: Text('Tambah Korban',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        primary: Colors.blue,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showPelakuDialog(context);
                      },
                      child: Text(
                        'Tambah Pelaku',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        textStyle: TextStyle(color: Colors.white),
                        primary: Colors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  controller: uraianController,
                  decoration: InputDecoration(
                    labelText: 'Uraian Kejadian',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Uraian Kejadian';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: kerugianController,
                  decoration: InputDecoration(
                    labelText: 'Kerugian Akibat Kejadian',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Kerugian Akibat Kejadian';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: penangananController,
                  decoration: InputDecoration(
                    labelText: 'Penanganan Kejadian/Peristiwa',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Penanganan Kejadian/Peristiwa';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: keteranganController,
                  decoration: InputDecoration(
                    labelText: 'Keterangan Lain',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Keterangan Lain';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createFormulirPelaporanKejadian();
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showKorbanDialog(BuildContext context) async {
    TextEditingController namaKorbanController = TextEditingController();
    TextEditingController umurKorbanController = TextEditingController();
    TextEditingController pekerjaanKorbanController = TextEditingController();
    TextEditingController alamatKorbanController = TextEditingController();
    TextEditingController noTlpKorbanController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Korban'),
          content: Column(
            children: [
              TextFormField(
                controller: namaKorbanController,
                decoration: InputDecoration(labelText: 'Nama Korban'),
              ),
              TextFormField(
                controller: umurKorbanController,
                decoration: InputDecoration(labelText: 'Umur Korban'),
              ),
              TextFormField(
                controller: pekerjaanKorbanController,
                decoration: InputDecoration(labelText: 'Pekerjaan Korban'),
              ),
              TextFormField(
                controller: alamatKorbanController,
                decoration: InputDecoration(labelText: 'Alamat Korban'),
              ),
              TextFormField(
                controller: noTlpKorbanController,
                decoration: InputDecoration(labelText: 'No. Telp Korban'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Add logic to save Korban details
                String namaKorban = namaKorbanController.text;
                String umurKorban = umurKorbanController.text;
                String pekerjaanKorban = pekerjaanKorbanController.text;
                String alamatKorban = alamatKorbanController.text;
                String noTlpKorban = noTlpKorbanController.text;

                // Do something with the Korban details
                // print('Nama Korban: $namaKorban');
                // print('Umur Korban: $umurKorban');
                // print('Pekerjaan Korban: $pekerjaanKorban');
                // print('Alamat Korban: $alamatKorban');
                // print('No. Telp Korban: $noTlpKorban');

                KorbanController.add({
                  "nama_korban": '$namaKorban',
                  "umur_korban": umurKorban,
                  "pekerjaan_korban": '$pekerjaanKorban',
                  "alamat_korban": '$alamatKorban',
                  "no_tlp_korban": noTlpKorban,
                });
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPelakuDialog(BuildContext context) async {
    TextEditingController namaPelakuController = TextEditingController();
    TextEditingController umurPelakuController = TextEditingController();
    TextEditingController pekerjaanPelakuController = TextEditingController();
    TextEditingController alamatPelakuController = TextEditingController();
    TextEditingController noTlpPelakuController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Pelaku'),
          content: Column(
            children: [
              TextFormField(
                controller: namaPelakuController,
                decoration: InputDecoration(labelText: 'Nama Pelaku'),
              ),
              TextFormField(
                controller: umurPelakuController,
                decoration: InputDecoration(labelText: 'Umur Pelaku'),
              ),
              TextFormField(
                controller: pekerjaanPelakuController,
                decoration: InputDecoration(labelText: 'Pekerjaan Pelaku'),
              ),
              TextFormField(
                controller: alamatPelakuController,
                decoration: InputDecoration(labelText: 'Alamat Pelaku'),
              ),
              TextFormField(
                controller: noTlpPelakuController,
                decoration: InputDecoration(labelText: 'No. Telp Pelaku'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                String namaPelaku = namaPelakuController.text;
                String umurPelaku = umurPelakuController.text;
                String pekerjaanPelaku = pekerjaanPelakuController.text;
                String alamatPelaku = alamatPelakuController.text;
                String noTlpPelaku = noTlpPelakuController.text;

                // print('Nama Pelaku: $namaPelaku');
                // print('Umur Pelaku: $umurPelaku');
                // print('Pekerjaan Pelaku: $pekerjaanPelaku');
                // print('Alamat Pelaku: $alamatPelaku');
                // print('No. Telp Pelaku: $noTlpPelaku');

                PelakuController.add({
                  "nama_pelaku": '$namaPelaku',
                  "umur_pelaku": umurPelaku,
                  "pekerjaan_pelaku": '$pekerjaanPelaku',
                  "alamat_pelaku": '$alamatPelaku',
                  "no_tlp_pelaku": noTlpPelaku,
                });
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void createFormulirPelaporanKejadian() async {
    try {
      String tempatKejadian = tempatController.text;
      String kerugianAkibatKejadian = kerugianController.text;
      String penanganan = penangananController.text;
      String keteranganLain = keteranganController.text;

      if (selectedJenisKejadian.isEmpty ||
          selectedTanggalWaktuKejadian == null) {
        return;
      }

      // Replace the placeholders with actual values from your dialog
      String namaKorban = ''; // Replace with actual value
      int umurKorban = 0; // Replace with actual value
      String pekerjaanKorban = ''; // Replace with actual value
      String alamatKorban = ''; // Replace with actual value
      int noTlpKorban = 0; // Replace with actual value

      // Replace the placeholders with actual values from your dialog
      String namaPelaku = ''; // Replace with actual value
      int umurPelaku = 0; // Replace with actual value
      String pekerjaanPelaku = ''; // Replace with actual value
      String alamatPelaku = ''; // Replace with actual value
      int noTlpPelaku = 0; // Replace with actual value

      FormulirPelaporanKejadianRepository repository =
          FormulirPelaporanKejadianRepository();
      // print(selectedJenisKejadian);
      // print(selectedTanggalWaktuKejadian);
      // print(tempatKejadian);
      // print(kerugianAkibatKejadian);
      // print(penanganan);
      // print(keteranganLain);
      // print(KorbanController);
      // print(PelakuController);
      await repository.createFormulirPelaporanKejadian(
        jenisKejadian: selectedJenisKejadian,
        tanggalWaktuKejadian: selectedTanggalWaktuKejadian.toString(),
        tempatKejadian: tempatKejadian,
        kerugianAkibatKejadian: kerugianAkibatKejadian,
        penanganan: penanganan,
        keteranganLain: keteranganLain,
        korban: KorbanController,
        pelaku: PelakuController,
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error creating FormulirPelaporanKejadian: $e');
    }
  }
}
