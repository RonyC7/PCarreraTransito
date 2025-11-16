import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergenciaPage extends StatelessWidget {
  const EmergenciaPage({super.key});

  void _llamar(String numero) async {
    final uri = Uri(scheme: 'tel', path: numero);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo llamar al número $numero';
    }
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactos de Emergencia'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: Colors.red.shade600,
              child: ListTile(
                title: const Text(
                  'Contactos de Emergencia',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Numeros importantes para situaciones de emergencia en La Esperanza',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.local_police, color: Colors.blue),
                title: const Text('Policía Municipal de Tránsito'),
                subtitle: const Text('PMT'),
                trailing: ElevatedButton.icon(
                  onPressed: () => _llamar('7772-0578'),
                  icon: const Icon(Icons.call),
                  label: const Text('Llamar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.local_fire_department,
                  color: Colors.red,
                ),
                title: const Text('Bomberos Voluntarios'),
                subtitle: const Text('Bomberos Voluntarios'),
                trailing: ElevatedButton.icon(
                  onPressed: () => _llamar('7772-0692'),
                  icon: const Icon(Icons.call),
                  label: const Text('Llamar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.local_hospital, color: Colors.green),
                title: const Text('Hospital General'),
                subtitle: const Text('La Esperanza'),
                trailing: ElevatedButton.icon(
                  onPressed: () => _llamar('7772-1234'),
                  icon: const Icon(Icons.call),
                  label: const Text('Llamar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
