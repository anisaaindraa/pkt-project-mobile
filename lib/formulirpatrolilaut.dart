import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patroli_app/model/patroli_laut_model.dart';
import 'package:patroli_app/service/patrolilautservice.dart';
import 'package:image_picker/image_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class FormulirPatroliLautPage extends StatefulWidget {
  @override
  _FormulirPatroliLautPageState createState() =>
      _FormulirPatroliLautPageState();
}

class _FormulirPatroliLautPageState extends State<FormulirPatroliLautPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController uraianHasilController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  int? selectedMShiftId;
  DateTime? selectedTanggalKejadian;
  XFile? selectedPhotoPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Patroli Laut'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 30),
              DropdownButtonFormField<int>(
                value: selectedMShiftId,
                items: [
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text('Pagi'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text('Siang'),
                  ),
                  DropdownMenuItem<int>(
                    value: 3,
                    child: Text('Sore'),
                  ),
                  DropdownMenuItem<int>(
                    value: 4,
                    child: Text('Malam'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedMShiftId = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'M Shift',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white, // White background color
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Pilih M Shift';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              DateTimeField(
                format: DateFormat("yyyy-MM-dd HH:mm:ss"),
                onChanged: (date) {
                  selectedTanggalKejadian = date;
                },
                decoration: InputDecoration(
                  labelText: 'Tanggal Kejadian',
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
                controller: uraianHasilController,
                decoration: InputDecoration(
                  labelText: 'Uraian Hasil',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white, // White background color
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Uraian Hasil';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: keteranganController,
                decoration: InputDecoration(
                  labelText: 'Keterangan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white, // White background color
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Keterangan';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final XFile? pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );

                  setState(() {
                    selectedPhotoPath = pickedFile;
                  });
                },
                child: Text(
                  'Choose Photo',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  primary: Colors.blue,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createFormulirPatroliLaut();
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  primary: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createFormulirPatroliLaut() async {
    try {
      String uraianHasil = uraianHasilController.text;
      String keterangan = keteranganController.text;

      if (selectedMShiftId == null ||
          selectedTanggalKejadian == null ||
          selectedPhotoPath == null) {
        return;
      }

      FormulirPatroliLautRepository repository =
          FormulirPatroliLautRepository();

      await repository.createFormulirPatroliLaut(
        1,
        selectedTanggalKejadian.toString(),
        selectedMShiftId.toString(),
        uraianHasil,
        keterangan,
        [PhotoPatroliLaut(photo_path: selectedPhotoPath!.path)],
        'Your Device ID',
      );
    } catch (e) {
      print('Error creating FormulirPatroliLaut: $e');
    }
  }
}
