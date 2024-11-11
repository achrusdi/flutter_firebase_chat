import 'package:e_isocomm/screens/login_screen.dart';
import 'package:e_isocomm/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        toggleScreens: toggleScreens,
      );
    } else {
      return RegisterPage(
        toggleScreens: toggleScreens,
      );
    }
  }
}
