import 'package:flutter/material.dart';

class CiudadanoPage extends StatelessWidget {
  const CiudadanoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Bienvenido, Ciudadano', style: TextStyle(fontSize: 22)),
      ),
    );
  }
}