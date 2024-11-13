import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_isocomm/screens/initial_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // instance auth and firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign in
  Future<UserCredential?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog(context, "Email atau password tidak boleh kosong.");
      return null;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // throw Exception(e.code);
      _showErrorDialog(context, "Login gagal: ${e.message}");
      return null;
    }
  }

  // sign up
  Future<UserCredential?> signUpWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog(context, "Email atau password tidak boleh kosong.");
      return null;
    }

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // save user info in current doc
      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const InitialScreen()),
    );
  }

  // sign out confirm
  Future<bool> confirmSignOut(BuildContext context) async {
    final bool? shouldSignOut = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Keluar"),
          content: const Text("Apakah Anda yakin ingin keluar?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );

    return shouldSignOut ?? false;
  }

  // get current user
  User? getCurrentUser() => _auth.currentUser;

  // errors
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Peringatan"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
