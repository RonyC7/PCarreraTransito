import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>?> login(String correo, String contrasena) async {
    final response = await _supabase.rpc('verificar_login', params: {
      '_correo': correo,
      '_contrasena': contrasena,
    });

    if (response.isEmpty) return null;
    return response[0] as Map<String, dynamic>;
  } 

  Future<void> register({
    required String nombre,
    required String correo,
    required String contrasena,
    required String telefono,
  }) async {
    final rol = await _supabase
        .from('roles')
        .select('id')
        .eq('nombre', 'Ciudadano')
        .maybeSingle();

    final idRol = rol?['id'];

    await _supabase.from('usuarios').insert({
      'id_rol': idRol,
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena,
      'telefono': telefono,
    });
  }
    
    Future<void> signOut() async {
      await _supabase.auth.signOut();
    }
  }


