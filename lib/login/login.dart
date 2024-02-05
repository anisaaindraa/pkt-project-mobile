import 'package:flutter/material.dart';
import 'package:patroli_app/dashboard.dart'; // Sesuaikan dengan lokasi file Dashboard

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Dummy login logic
  bool loginBerhasil = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 32.0),
        ElevatedButton(
          onPressed: () {
            // Implementasi logika login
            final String email = _emailController.text;
            final String password = _passwordController.text;

            // Tambahkan logika validasi atau login ke server di sini
            print('Email: $email');
            print('Password: $password');

            // Dummy login berhasil
            if (email == 'dummy@example.com' && password == 'password') {
              setState(() {
                loginBerhasil = true;
              });

              // Navigasi ke dashboard jika login berhasil
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Dashboard(title: 'Patroli PKT')));
            } else {
              // Tampilkan pesan atau notifikasi login gagal
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Login gagal. Silakan coba lagi.'),
              ));
            }
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
