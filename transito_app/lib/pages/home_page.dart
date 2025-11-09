import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Map<String, dynamic> user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: Center(
        child: Text(
          'Bienvenido, ${user['nombre']}',

          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}