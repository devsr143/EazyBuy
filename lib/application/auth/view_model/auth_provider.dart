import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        Fluttertoast.showToast(
          msg:'Account created successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushNamedAndRemoveUntil(context, '/root', (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg:'Sign up failed',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg:'Error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
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
      Fluttertoast.showToast(
        msg:'Login failed',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg:'Error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
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