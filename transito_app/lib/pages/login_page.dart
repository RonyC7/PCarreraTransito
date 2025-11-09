import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage ({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;
  final auth = AuthService();

  Future<void> _login() async {
    setState(() => loading = true);
    try{
      final user = await auth.login(emailCtrl.text.trim(), passCtrl.text.trim());
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales incorrectas')),
        );
      } else {
        final role = user['id_rol'] ?? 0;

        if (role ==1) {
          Navigator.pushReplacementNamed(context, '/admin');
        } else if (role == 2) {
          Navigator.pushReplacementNamed(context, '/agente');
        } else {
          Navigator.pushReplacementNamed(context, '/ciudadano');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Iniciar Sesión')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailCtrl,
            decoration: const InputDecoration(
              labelText: 'Correo',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: passCtrl,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: loading ? null : _login,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Entrar'),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const RegisterPage()),
              );
            },
            child: const Text('¿No tienes una cuenta? Regístrate aquí'),
          ),
        ],
      ),
    ),
  );
}
}