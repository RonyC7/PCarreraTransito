import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:transito_app/pages/dashboard_page.dart';
import 'pages/login_page.dart';
import 'pages/admin_page.dart';
import 'pages/agente_page.dart';
import 'pages/ciudadano_page.dart';

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
      home: const DashboardPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/admin': (context) => const AdminPage(),
        '/agente': (context) => const AgentePage(),
        '/ciudadano': (context) => const CiudadanoPage(),
      },
    );
  }
}
