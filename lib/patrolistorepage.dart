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
      // ... existing code

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to FormulirPatroliLautPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormulirPatroliLautPage(),
            ),
          ).then((newForm) {
            // Callback when formulir baru disubmit
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

class PatroliFormData {}
