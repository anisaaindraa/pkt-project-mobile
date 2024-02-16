import 'package:flutter/material.dart';
import 'flutter/component/navbar.dart'; // Sesuaikan path sesuai lokasi file

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Patroli',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Dashboard(title: 'Patroli PKT'),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Patroli PKT'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          FormCard(
            title: 'Formulir Patroli Laut',
            onTap: () {
              Navigator.pushNamed(context, '/patroliForm');
              // Handle navigation to Formulir Patroli Laut page
              print('Navigating to Formulir Patroli Laut');
            },
          ),
          FormCard(
            title: 'Formulir Pelaksanaan Tugas',
            onTap: () {
              // Handle navigation to Formulir Pelaksanaan Tugas page
              print('Navigating to Formulir Pelaksanaan Tugas');
            },
          ),
          FormCard(
            title: 'Formulir Pelaporan Kejadian',
            onTap: () {
              Navigator.pushNamed(context, '/pelaporankejadianform');
              print('Navigating to Formulir Pelaporan Kejadian');
            },
          ),
        ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}

class FormCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const FormCard({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
