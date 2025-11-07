import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Tránsito La Esperanza',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _testSupabaseConnection(BuildContext context) async {
    try {
      final supabase = Supabase.instance.client;
      final data = await supabase.from('roles').select();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('conexion exitosa con supabase')),
      );
      debugPrint('Datos de roles: $data');
    } catch (e) {
      ScaffoldMessenger.of (context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
  
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Conexion a supabase'),
    ),
    body: Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.cloud_done_outlined),
        label: const Text('Probar conexion con la base de datos'),
        onPressed: () => _testSupabaseConnection(context),
      ),
    ),
  );
}
}