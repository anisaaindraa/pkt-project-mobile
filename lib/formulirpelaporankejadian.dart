import 'package:flutter/material.dart';

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
  final TextEditingController _penangananController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  final TextEditingController _jenisKejadianLainnyaController =
      TextEditingController();

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
            _buildTextField(
              'Nama Pelapor',
              TextInputType.text,
              (value) {},
            ),
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
              'Penanganan Kejadian',
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

  void _submitForm() {
    // Implementasi logika pengiriman data ke server atau penyimpanan lokal
    // Gunakan data yang sudah diisi pada state untuk dikirim atau disimpan
    // Sesuaikan dengan kebutuhan aplikasi Anda
    print('Nama Pelapor: ${_pelakuList.join(", ")}');
    print('Jenis Kejadian: $_selectedJenisKejadian');
    print('Tanggal Kejadian: $_selectedDate');
    print('Waktu Kejadian: $_selectedTime');
    print('Tempat Kejadian: ${_uraianController.text}');
    print('Pelaku: ${_pelakuList.join(", ")}');
    print('Korban: ${_korbanList.join(", ")}');
    print('Uraian Kejadian: ${_uraianController.text}');
    print('Kerugian Akibat Kejadian: ${_kerugianController.text}');
    print('Penanganan Kejadian: ${_penangananController.text}');
    print('Keterangan Lain-lain: ${_keteranganController.text}');
  }
}
