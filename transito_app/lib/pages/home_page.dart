import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';
import 'register_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  Map<String, dynamic>? currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final session = supabase.auth.currentSession;
    if (session != null && session.user != null) {
      final data = await supabase
          .from('usuarios')
          .select('nombre, correo')
          .eq('correo', session.user.email ?? '')
          .maybeSingle();
        setState(() => currentUser = data);
    }
  }

  void _logout() async {
    await supabase.auth.signOut();
    setState(() => currentUser = null);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sesión cerrada correctamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Tránsito La Esperanza'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.person),
            onSelected: (value) {
              if (value == 'login') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              } else if (value == 'register') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              } else if (value == 'logout') {
                _logout();
              }
            },
           itemBuilder: (context) {
              if (currentUser == null) {
               return [
              const PopupMenuItem(value: 'login', child: Text('Iniciar sesión')),
              const PopupMenuItem(value: 'register', child: Text('Registrarse')),
              ];
            } else {
              return [
                PopupMenuItem(
                  value: 'profile',
                  enabled: false,
                  child: Text(' ${currentUser!['nombre']}'),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(value: 'logout', child: Text('Cerrar Sesión')),
              ];
            }
          },
          ),
      ],
    ),
    body: Center(
      child: currentUser == null
          ? const Text(
            'Bienvenido al Sistema de Tránsito \nPor favor inicia sesión para continuar.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          )
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bienvenido, ${currentUser!['nombre']}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              const Text(
                "Panel/Dashboard de usuario",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
      ),
    );
}
}