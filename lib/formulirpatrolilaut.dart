import 'package:flutter/material.dart';

class PatroliForm extends StatefulWidget {
  const PatroliForm({Key? key}) : super(key: key);

  @override
  _PatroliFormState createState() => _PatroliFormState();
}

class _PatroliFormState extends State<PatroliForm> {
  DateTime?
      _selectedDate; // Tambahkan variabel untuk menyimpan tanggal terpilih
  String? _selectedShift; // Tambahkan variabel untuk menyimpan shift terpilih
  final TextEditingController _uraianController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  final TextEditingController _namaPelaporController = TextEditingController();
  List<String> _photos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Patroli Laut'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            _buildTextField(
              _namaPelaporController,
              'Nama Pelapor',
              TextInputType.text,
            ),
            const SizedBox(height: 20),
            _buildDateInput(),
            const SizedBox(height: 20),
            _buildShiftDropdown(),
            const SizedBox(height: 20),
            _buildTextField(
              _uraianController,
              'Uraian Hasil Patroli',
              TextInputType.multiline,
            ),
            const SizedBox(height: 20),
            _buildPhotoInput(),
            const SizedBox(height: 20),
            _buildTextField(
              _keteranganController,
              'Keterangan',
              TextInputType.multiline,
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
          TextEditingController(
            text: _selectedDate != null
                ? _selectedDate!.toLocal().toString().split(' ')[0]
                : '',
          ),
          'Tanggal',
          TextInputType.datetime,
        ),
      ),
    );
  }

  Widget _buildShiftDropdown() {
    return CustomDropdown(
      selectedValue: _selectedShift,
      items: ['Shift 1', 'Shift 2', 'Shift 3', 'Shift 4'],
      onChanged: (value) {
        setState(() {
          _selectedShift = value;
        });
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    TextInputType inputType,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
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
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none, // Tidak ada border di dalam TextField
          contentPadding: EdgeInsets.all(12), // Padding isi input box
        ),
        keyboardType: inputType,
      ),
    );
  }

  Widget _buildPhotoInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Foto Patroli', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: _takePhoto,
              child: const Text('Ambil Foto'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Warna latar belakang button
                onPrimary: Colors.black, // Warna teks button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(
                  color: Colors.grey, // Warna border button
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _photos
                      .map(
                        (photo) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // Warna latar belakang
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
                              child:
                                  Image.network(photo, width: 50, height: 50),
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

  void _takePhoto() {
    setState(() {
      _photos.add('https://via.placeholder.com/150');
    });
  }

  void _submitForm() {
    final tanggal = _selectedDate != null
        ? _selectedDate!.toLocal().toString().split(' ')[0]
        : '';
    final shift = _selectedShift ?? '';
    final uraian = _uraianController.text;
    final keterangan = _keteranganController.text;

    print('Tanggal: $tanggal');
    print('Shift: $shift');
    print('Uraian Hasil Patroli: $uraian');
    print('Foto Patroli: $_photos');
    print('Keterangan: $keterangan');
  }
}

class CustomDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  CustomDropdown({
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String?>(
      value: selectedValue,
      hint: Text('Pilih Shift'),
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem<String?>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
