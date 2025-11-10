import 'package:flutter/material.dart';

class EmergenciaPage extends StatelessWidget {
  const EmergenciaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          ' Página de emergencia',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
