import 'package:flutter/material.dart';
import 'package:patroli_app/model/pelaporan_kejadian_model.dart';
import 'package:patroli_app/service/pelaporankejadianservice.dart';
import 'package:intl/intl.dart';

class PelaporanKejadianForm extends StatefulWidget {
  const PelaporanKejadianForm({Key? key}) : super(key: key);

  @override
  _PelaporanKejadianFormState createState() => _PelaporanKejadianFormState();
}

class _PelaporanKejadianFormState extends State<PelaporanKejadianForm> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedJenisKejadian;
  List<String> _pelakuList = [];
  List<String> _korbanList = [];
  final TextEditingController _uraianController = TextEditingController();
  final TextEditingController _kerugianController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  final TextEditingController _jenisKejadianLainnyaController =
      TextEditingController();

  DateTime? _convertTimeOfDayToDateTime(TimeOfDay? timeOfDay) {
    if (timeOfDay != null) {
      final now = DateTime.now();
      return DateTime(
          now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Pelaporan Kejadian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            _buildDropdown(
              'Jenis Kejadian',
              ['Kejahatan', 'Pelanggaran', 'Kecelakaan', 'Lain-lain'],
              (value) {
                setState(() {
                  _selectedJenisKejadian = value;
                });
              },
            ),
            const SizedBox(height: 20),
            if (_selectedJenisKejadian == 'Lain-lain')
              _buildTextField(
                'Jenis Kejadian Lainnya',
                TextInputType.text,
                (value) {},
                controller: _jenisKejadianLainnyaController,
              ),
            const SizedBox(height: 20),
            _buildDateInput(),
            const SizedBox(height: 20),
            _buildTimeInput(),
            const SizedBox(height: 20),
            _buildTextField(
              'Tempat Kejadian',
              TextInputType.text,
              (value) {},
            ),
            const SizedBox(height: 20),
            _buildPelakuKorbanInput('Pelaku', _pelakuList),
            const SizedBox(height: 20),
            _buildPelakuKorbanInput('Korban', _korbanList),
            const SizedBox(height: 20),
            _buildTextField(
              'Uraian Kejadian',
              TextInputType.multiline,
              (value) {},
            ),
            const SizedBox(height: 20),
            _buildTextField(
              'Kerugian Akibat Kejadian',
              TextInputType.multiline,
              (value) {},
            ),
            const SizedBox(height: 20),
            _buildTextField(
              'Keterangan Lain-lain',
              TextInputType.multiline,
              (value) {},
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextInputType inputType,
    Function(String) onChanged, {
    TextEditingController? controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) => onChanged(value),
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12),
        ),
        keyboardType: inputType,
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    Function(String) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: _selectedJenisKejadian,
      hint: Text(label),
      onChanged: (value) => onChanged(value!),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }

  Widget _buildDateInput() {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
      child: IgnorePointer(
        child: _buildTextField(
          'Tanggal Kejadian',
          TextInputType.datetime,
          (value) {},
        ),
      ),
    );
  }

  Widget _buildTimeInput() {
    return InkWell(
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: _selectedTime ?? TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            _selectedTime = pickedTime;
          });
        }
      },
      child: IgnorePointer(
        child: _buildTextField(
          'Waktu Kejadian',
          TextInputType.datetime,
          (value) {},
        ),
      ),
    );
  }

  Widget _buildPelakuKorbanInput(String label, List<String> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label'),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _showModalForm(label);
              },
              child: Text('Tambah $label'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: list
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Text(item),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showModalForm(String label) {
    String? nama;
    String? umur;
    String? pekerjaan;
    String? alamat;
    String? noTlp;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah $label'),
          content: Column(
            children: [
              _buildTextField(
                'Nama $label',
                TextInputType.text,
                (value) {
                  nama = value;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Umur $label',
                TextInputType.number,
                (value) {
                  umur = value;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Pekerjaan $label',
                TextInputType.text,
                (value) {
                  pekerjaan = value;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Alamat $label',
                TextInputType.text,
                (value) {
                  alamat = value;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'No. Telp $label',
                TextInputType.phone,
                (value) {
                  noTlp = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    final String data =
                        '$nama, $umur, $pekerjaan, $alamat, $noTlp';
                    if (label == 'Pelaku') {
                      _pelakuList.add(data);
                    } else if (label == 'Korban') {
                      _korbanList.add(data);
                    }
                  });
                  Navigator.pop(context);
                },
                child: const Text('Tambah'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitForm() async {
    try {
      final FormulirPelaporanKejadianService repository =
          FormulirPelaporanKejadianService('http://127.0.0.1:8000');

      final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      final DateFormat timeFormat = DateFormat('HH:mm:ss');

      final FormulirPelaporanKejadian response =
          await repository.createFormulirPelaporanKejadian(
        usersId: 1,
        jenisKejadian: _selectedJenisKejadian ?? '',
        tanggalKejadian: dateFormat.format(_selectedDate ?? DateTime.now()),
        waktuKejadian: timeFormat.format(
            _convertTimeOfDayToDateTime(_selectedTime) ?? DateTime.now()),
        tempatKejadian: _uraianController.text,
        kerugianAkibatKejadian: _kerugianController.text,
        keteranganLain: _keteranganController.text,
        korban: _korbanList.map((data) {
          List<String> korbanData = data.split(', ');
          return Korban(
            namaKorban: korbanData[0],
            umurKorban: int.parse(korbanData[1]),
            pekerjaanKorban: korbanData[2],
            alamatKorban: korbanData[3],
            noTlpKorban: int.parse(korbanData[4]),
          );
        }).toList(),
        pelaku: _pelakuList.map((data) {
          List<String> pelakuData = data.split(', ');
          return Pelaku(
            namaPelaku: pelakuData[0],
            umurPelaku: int.parse(pelakuData[1]),
            pekerjaanPelaku: pelakuData[2],
            alamatPelaku: pelakuData[3],
            noTlpPelaku: int.parse(pelakuData[4]),
          );
        }).toList(),
      );

      print('Response from server: ${response.message}');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        print('Formulir Pelaporan Kejadian created successfully!');
      } else {
        print(
            'Failed to create Formulir Pelaporan Kejadian. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error submitting form: $e');
    }
  }
}
