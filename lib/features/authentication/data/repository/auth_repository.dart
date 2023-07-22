import '../authentication_data.dart';

class AuthRepository {
  final AuthProvider authProvider = AuthProvider();
  
  Future<void> signUp({User? user}) async {
    try {
      await authProvider.signUp(user!);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    return await authProvider.login(email: email, password: password);
  }
}
