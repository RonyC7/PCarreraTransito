import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>?> login(String correo, String contrasena) async {
    final response = await _supabase.rpc(
      'verificar_login',
      params: {'_correo': correo, '_contrasena': contrasena},
    );

    if (response.isEmpty) return null;

    await _supabase.auth.signInWithPassword(
      email: correo,
      password: contrasena,
    );
    return response[0] as Map<String, dynamic>;
  }

  Future<void> register({
    required String nombre,
    required String correo,
    required String contrasena,
    required String telefono,
  }) async {
    final existingUser = await _supabase
        .from('usuarios')
        .select('correo')
        .eq('correo', correo)
        .maybeSingle();

    if (existingUser != null) {
      throw Exception('El correo ya está registrado. Intenta iniciar sesión.');
    }

    try {
      final authResponse = await _supabase.auth.signUp(
        email: correo,
        password: contrasena,
        emailRedirectTo: null,
      );

      await _supabase.auth.signOut();

      if (authResponse.user == null) {
        throw Exception('Error al registrar el usuario');
      }

      final rol = await _supabase
          .from('roles')
          .select('id')
          .eq('nombre', 'Ciudadano')
          .maybeSingle();

      final idRol = rol?['id'] ?? 3;

      await _supabase.from('usuarios').insert({
        'id_rol': idRol,
        'nombre': nombre,
        'correo': correo,
        'contrasena': contrasena,
        'telefono': telefono,
        'estado': 'activo',
      });
    } on AuthApiException catch (e) {
      if (e.code == 'user_already_exists') {
        throw Exception('El correo ya se encuentra registrado.');
      } else {
        throw Exception('Error de autenticación: ${e.message}');
      }
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
