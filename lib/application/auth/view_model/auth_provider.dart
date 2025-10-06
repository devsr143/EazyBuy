import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pack_bags/application/auth/service/auth_service.dart';

class AuthenticationProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoading = false;
  User? _user;

  User? get currentUser => _user;
  bool get isLoggedIn => _user != null;

  AuthenticationProvider() {
    _user = _authService.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signUp(
      String email,
      String password,
      String firstName,
      String lastName,
      BuildContext context,
      ) async {
    try {
      isLoading = true;
      notifyListeners();

      User? user = await _authService.signUp(email, password, firstName, lastName);
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created successfully!")),
        );
        // Navigator.pushReplacementNamed(context, '/root');
        Navigator.pushNamedAndRemoveUntil(context, '/root', (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-up failed: ${e.message}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      User? user = await _authService.login(email, password);
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/root', (route) => false);      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.message}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    await _authService.logout();
    Navigator.pushReplacementNamed(context, '/');
    notifyListeners();
  }
}