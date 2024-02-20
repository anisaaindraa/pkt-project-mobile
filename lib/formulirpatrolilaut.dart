import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:patroli_app/flutter/component/dropdown.dart';
import 'package:patroli_app/model/patroli_laut_model.dart';

class Network {
  final String baseUrl;

  Network(this.baseUrl);

  Future<http.Response> postData(String path,
      {required Map<String, dynamic> body}) async {
    final response = await http.post(Uri.parse('$baseUrl$path'), body: body);
    return response;
  }
}

class FormulirPatroliLautService {
  final Network network;

  FormulirPatroliLautService(this.network);

  Future<FormulirPatroliLaut> createFormulirPatroliLaut(
    int usersId,
    String tanggalKejadian,
    int mShiftId,
    String uraianHasil,
    String keterangan,
    List<PhotoPatroliLaut> photoPatroliLaut,
  ) async {
    final response = await network.postData(
      "/api/formpatrolilaut",
      body: {
        'users_id': usersId.toString(),
        'tanggal_kejadian': tanggalKejadian,
        'm_shift_id': mShiftId.toString(),
        'uraian_hasil': uraianHasil,
        'keterangan': keterangan,
        'photo_patroli_laut': json.encode(
          photoPatroliLaut
              .map((photo) => {'photo_path': photo.photo_path})
              .toList(),
        ),
      },
    );
    return parseResponse(response.body);
  }

  FormulirPatroliLaut parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    return FormulirPatroliLaut.fromJson(parsed);
  }
}

class PatroliForm extends StatefulWidget {
  const PatroliForm({Key? key}) : super(key: key);

  @override
  _PatroliFormState createState() => _PatroliFormState();
}

class _PatroliFormState extends State<PatroliForm> {
  final _formulirPatroliLautService =
      FormulirPatroliLautService('http://127.0.0.1:8000');
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  String? _selectedShift;
  final TextEditingController _uraianController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  List<Map<String, dynamic>> _photosList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Patroli Laut'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              _buildTextField(
                _uraianController,
                'Uraian Hasil Patroli',
                TextInputType.multiline,
              ),
              const SizedBox(height: 20),
              _buildDateInput(),
              const SizedBox(height: 20),
              _buildShiftDropdown(),
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

  Widget _buildPhotoInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Foto Patroli', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: _showAddPhotoDialog,
              child: const Text('Tambah Foto'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _photosList.map((photo) {
                    return Padding(
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
                          child: Image.network(
                            photo['photo_path'],
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showAddPhotoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Foto'),
          content: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage();
                },
                child: const Text('Pilih dari Galeri'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _photosList.add({'photo_path': pickedFile.path});
      });
    }
  }

void _submitForm() async {
  final tanggal = _selectedDate != null
      ? _selectedDate!.toLocal().toString().split(' ')[0]
      : '';
  final shift = _selectedShift != null ? int.parse(_selectedShift!) : 0; // Convert to int or provide a default value
  final uraian = _uraianController.text;
  final keterangan = _keteranganController.text;
  final formData = {
    'usersId': 1, // Replace with actual user ID
    'tanggalKejadian': tanggal,
    'mShiftId': shift,
    'uraianHasil': uraian,
    'keterangan': keterangan,
    'photoPatroliLaut': _photosList,
  };

  try {
    // Call the API to create the Formulir Patroli Laut
    final result =
        await _formulirPatroliLautService.createFormulirPatroliLaut(
      formData['usersId'],
      formData['tanggalKejadian'],
      formData['mShiftId'],
      formData['uraianHasil'],
      formData['keterangan'],
      formData['photoPatroliLaut'],
    );

    if (result.success) {
      print('Formulir Patroli Laut created successfully!');
      // You can navigate to the store page or perform other actions
    } else {
      print(
          'Failed to create Formulir Patroli Laut. Message: ${result.message}');
      // Handle the failure, show an error message, etc.
    }
  } catch (e) {
    print('An error occurred: $e');
    // Handle other errors
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
}