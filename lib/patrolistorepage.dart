import 'package:flutter/material.dart';
import 'package:patroli_app/formulirpatrolilaut.dart';

class PatroliStorePage extends StatefulWidget {
  const PatroliStorePage({Key? key}) : super(key: key);

  @override
  _PatroliStorePageState createState() => _PatroliStorePageState();
}

class _PatroliStorePageState extends State<PatroliStorePage> {
  List<PatroliFormData> _patroliForms = []; // Simpan data formulir patroli

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histori Formulir Patroli'),
      ),
      body: _patroliForms.isEmpty
          ? Center(
              child: Text('Belum ada formulir patroli.'),
            )
          : ListView.builder(
              itemCount: _patroliForms.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('Tanggal: ${_patroliForms[index].tanggal}'),
                    subtitle: Text('Shift: ${_patroliForms[index].shift}'),
                    onTap: () {
                      // Tambahkan logika untuk menampilkan detail formulir patroli
                      // Misalnya, pindah ke halaman detail
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatroliForm(),
            ),
          ).then((newForm) {
            // Callback ketika formulir baru disubmit
            if (newForm != null && newForm is PatroliFormData) {
              setState(() {
                _patroliForms.add(newForm);
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PatroliFormData {
  final String tanggal;
  final String shift;

  PatroliFormData({
    required this.tanggal,
    required this.shift,
  });
}
