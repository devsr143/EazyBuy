//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AuthProvider with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   bool isLoading = false;
//
//   Future<void> signUp(
//       String email,
//       String password,
//       String firstName,
//       String lastName,
//       BuildContext context,
//       ) async {
//     try {
//       isLoading = true;
//       notifyListeners();
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       User? user = userCredential.user;
//
//       if (user != null) {
//         await _firestore.collection("users").doc(user.uid).set({
//           "uid": user.uid,
//           "firstName": firstName,
//           "lastName": lastName,
//           "email": email,
//           "createdAt": FieldValue.serverTimestamp(),
//         });
//       }
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Account created successfully!")),
//       );
//
//       Navigator.pushReplacementNamed(context, '/root');
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Sign-up failed: ${e.message}")),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${e.toString()}")),
//       );
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> login(String email, String password, BuildContext context) async {
//     try {
//       isLoading = true;
//       notifyListeners();
//
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//
//       Navigator.pushReplacementNamed(context, '/root');
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Login failed: ${e.message}")),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${e.toString()}")),
//       );
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//   Future<void> logout(BuildContext context) async {
//     await _auth.signOut();
//     Navigator.pushReplacementNamed(context, '/');
//     notifyListeners();
//   }
//   User? get currentUser => _auth.currentUser;
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pack_bags/application/auth/service/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoading = false;

  // --- Sign Up ---
  Future<void> signUp(
      String email, String password, String firstName, String lastName, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      User? user = await _authService.signUp(email, password, firstName, lastName);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created successfully!")),
        );
        Navigator.pushReplacementNamed(context, '/root');
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

  // --- Login ---
  Future<void> login(String email, String password, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      User? user = await _authService.login(email, password);

      if (user != null) {
        Navigator.pushReplacementNamed(context, '/root');
      }
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

  // --- Logout ---
  Future<void> logout(BuildContext context) async {
    await _authService.logout();
    Navigator.pushReplacementNamed(context, '/');
    notifyListeners();
  }

  // --- Current User ---
  User? get currentUser => _authService.currentUser;
}
