import 'package:flutter/material.dart';

class AgentePage extends StatelessWidget {
  const AgentePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Bienvenido, Agente', style: TextStyle(fontSize: 22)),
      ),
    );
  }
}