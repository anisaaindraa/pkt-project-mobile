import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PelaporanKejadianForm extends StatefulWidget {
  @override
  _PelaporanKejadianFormState createState() => _PelaporanKejadianFormState();
}

class _PelaporanKejadianFormState extends State<PelaporanKejadianForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedJenisKejadian = '';
  DateTime? selectedTanggalWaktuKejadian;
  TextEditingController _tempatController = TextEditingController();
  TextEditingController _uraianController = TextEditingController();
  TextEditingController _kerugianController = TextEditingController();
  TextEditingController _penangananController = TextEditingController();
  TextEditingController _keteranganController = TextEditingController();

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
          // Wrap with SingleChildScrollView
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
                ),
                if (selectedJenisKejadian == 'lain-lain')
                  TextFormField(
                    controller: _uraianController,
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
                  controller: _tempatController,
                  decoration: InputDecoration(
                    labelText: 'Tempat Kejadian',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
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
                  controller: _uraianController,
                  decoration: InputDecoration(
                    labelText: 'Uraian Kejadian',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _kerugianController,
                  decoration: InputDecoration(
                    labelText: 'Kerugian Akibat Kejadian',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _penangananController,
                  decoration: InputDecoration(
                    labelText: 'Penanganan Kerugian',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _keteranganController,
                  decoration: InputDecoration(
                    labelText: 'Keterangan Lain',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Call your API service to submit the form
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
    TextEditingController _namaKorbanController = TextEditingController();
    TextEditingController _umurKorbanController = TextEditingController();
    TextEditingController _pekerjaanKorbanController = TextEditingController();
    TextEditingController _alamatKorbanController = TextEditingController();
    TextEditingController _noTlpKorbanController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Korban'),
          content: Column(
            children: [
              TextFormField(
                controller: _namaKorbanController,
                decoration: InputDecoration(labelText: 'Nama Korban'),
              ),
              TextFormField(
                controller: _umurKorbanController,
                decoration: InputDecoration(labelText: 'Umur Korban'),
              ),
              TextFormField(
                controller: _pekerjaanKorbanController,
                decoration: InputDecoration(labelText: 'Pekerjaan Korban'),
              ),
              TextFormField(
                controller: _alamatKorbanController,
                decoration: InputDecoration(labelText: 'Alamat Korban'),
              ),
              TextFormField(
                controller: _noTlpKorbanController,
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
                String namaKorban = _namaKorbanController.text;
                String umurKorban = _umurKorbanController.text;
                String pekerjaanKorban = _pekerjaanKorbanController.text;
                String alamatKorban = _alamatKorbanController.text;
                String noTlpKorban = _noTlpKorbanController.text;

                // Do something with the Korban details
                print('Nama Korban: $namaKorban');
                print('Umur Korban: $umurKorban');
                print('Pekerjaan Korban: $pekerjaanKorban');
                print('Alamat Korban: $alamatKorban');
                print('No. Telp Korban: $noTlpKorban');

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
    TextEditingController _namaPelakuController = TextEditingController();
    TextEditingController _umurPelakuController = TextEditingController();
    TextEditingController _pekerjaanPelakuController = TextEditingController();
    TextEditingController _alamatPelakuController = TextEditingController();
    TextEditingController _noTlpPelakuController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Pelaku'),
          content: Column(
            children: [
              TextFormField(
                controller: _namaPelakuController,
                decoration: InputDecoration(labelText: 'Nama Pelaku'),
              ),
              TextFormField(
                controller: _umurPelakuController,
                decoration: InputDecoration(labelText: 'Umur Pelaku'),
              ),
              TextFormField(
                controller: _pekerjaanPelakuController,
                decoration: InputDecoration(labelText: 'Pekerjaan Pelaku'),
              ),
              TextFormField(
                controller: _alamatPelakuController,
                decoration: InputDecoration(labelText: 'Alamat Pelaku'),
              ),
              TextFormField(
                controller: _noTlpPelakuController,
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
                // Add logic to save Pelaku details
                String namaPelaku = _namaPelakuController.text;
                String umurPelaku = _umurPelakuController.text;
                String pekerjaanPelaku = _pekerjaanPelakuController.text;
                String alamatPelaku = _alamatPelakuController.text;
                String noTlpPelaku = _noTlpPelakuController.text;

                // Do something with the Pelaku details
                print('Nama Pelaku: $namaPelaku');
                print('Umur Pelaku: $umurPelaku');
                print('Pekerjaan Pelaku: $pekerjaanPelaku');
                print('Alamat Pelaku: $alamatPelaku');
                print('No. Telp Pelaku: $noTlpPelaku');

                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
