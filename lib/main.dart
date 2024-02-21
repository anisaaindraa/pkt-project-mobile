import 'package:flutter/material.dart';
import 'package:patroli_app/flutter/component/app_colors.dart';
import 'package:patroli_app/formulirpatrolilaut.dart';
import 'package:patroli_app/formulirpelaporankejadian.dart';
import 'package:patroli_app/login/login.dart';
import 'package:patroli_app/patrolistorepage.dart';
// import 'package:patroli_app/patrolistorepage.dart';
import 'config.dart';

void main() {
  runApp(const MyApp());
  print('MySQL Host: ${MySQLConfig.host}');
  print('MySQL Port: ${MySQLConfig.port}');
  print('MySQL Database: ${MySQLConfig.database}');
  print('MySQL User: ${MySQLConfig.user}');
  print('MySQL Password: ${MySQLConfig.password}');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Patroli',
      theme: ThemeData(
        primaryColor: AppColors.orange,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: AppColors.orange,
        ).copyWith(secondary: AppColors.orange),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/dashboard': (context) => const Dashboard(title: 'Patroli PKT'),
        '/patroliForm': (context) => FormulirPatroliLautPage(),
        '/patrolistoreForm': (context) => const PatroliStorePage(),
        '/pelaporankejadianform': (context) => const PelaporanKejadianForm(),
      },
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.title});
  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          FormCard(
            title: 'Formulir Patroli Laut',
            onTap: () {
              Navigator.pushNamed(context, '/patroliForm');
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
              // Handle navigation to Formulir Pelaporan Kejadian page
              print('Navigating to Formulir Pelaporan Kejadian');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const FormCard({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
