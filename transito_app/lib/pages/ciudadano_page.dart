import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CiudadanoPage extends StatefulWidget {
  const CiudadanoPage({super.key});

  @override
  State<CiudadanoPage> createState() => _CiudadanoPageState();
}

class _CiudadanoPageState extends State<CiudadanoPage> {
  final supabase = Supabase.instance.client;
  Map<String, dynamic>? userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final session = supabase.auth.currentSession;
    if (session != null) {
      final data = await supabase
          .from('usuarios')
          .select('nombre, correo, telefono, estado')
          .eq('correo', session.user.email ?? '')
          .maybeSingle();
      setState(() {
        userData = data;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  void _logout() async {
    await supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final nombre = userData?['nombre'] ?? '';
    final correo = userData?['correo'] ?? '';
    final telefono = userData?['telefono'] ?? '';
    final estado = userData?['estado'] ?? '';

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (userData == null) {
      return const Scaffold(
        body: Center(child: Text('No has iniciado sesión.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        title: const Text('Mi Perfil'),
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.orange[400],
                      child: Text(
                        nombre.isNotEmpty ? nombre[0].toUpperCase() : '?',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      nombre,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(correo),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(telefono),
                  ),
                  ListTile(
                    leading: const Icon(Icons.check_circle),
                    title: Text('Estado: $estado'),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: _logout,
                    icon: const Icon(Icons.logout),
                    label: const Text('Cerrar sesión'),
                  ),
                ],
              ),
            ),
    );
  }
}
