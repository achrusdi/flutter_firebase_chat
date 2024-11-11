import 'package:e_isocomm/services/auth_service.dart';
import 'package:e_isocomm/utils/will_pop_scope_wrapper.dart';
import 'package:e_isocomm/widgets/button_wg.dart';
import 'package:e_isocomm/widgets/textfield_wg.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  final void Function()? toggleScreens;

  RegisterPage({super.key, required this.toggleScreens});

  void attemptRegister(BuildContext context) async {
    final _authService = AuthService();

    if (_passwordController.text != _repeatPasswordController.text) {
      showDialog(
          context: context,
          builder: (context) =>
              const AlertDialog(content: Text("Passwords don't match")));
    } else {
      try {
        await _authService.signUpWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScopeWrapper(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(
                Icons.message,
                size: 160,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 50),

              // Message
              Text(
                "Whatnyap ges!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),

              const SizedBox(height: 25),

              // Email text field
              TextfieldWg(
                hintText: 'email',
                obscureText: false,
                controller: _emailController,
              ),

              const SizedBox(height: 10),

              // Pass text field
              TextfieldWg(
                hintText: 'password',
                obscureText: true,
                controller: _passwordController,
              ),

              const SizedBox(height: 10),

              // Pass text field
              TextfieldWg(
                hintText: 'repeat password',
                obscureText: true,
                controller: _repeatPasswordController,
              ),

              const SizedBox(height: 25),

              // Login button
              ButtonWg(
                text: "Register",
                onTap: () => attemptRegister(context),
              ),

              const SizedBox(height: 25),

              // Register button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: toggleScreens,
                    child: const Text(
                      "Login Now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
