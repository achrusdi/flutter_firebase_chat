import 'package:e_isocomm/services/auth_service.dart';
import 'package:e_isocomm/utils/will_pop_scope_wrapper.dart';
import 'package:e_isocomm/widgets/button_wg.dart';
import 'package:e_isocomm/widgets/textfield_wg.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final void Function()? toggleScreens;

  LoginPage({super.key, required this.toggleScreens});

  // Login method
  void attemptLogin(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(content: Text(e.toString())));
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

              const SizedBox(height: 25),

              // Login button
              ButtonWg(
                text: "Login",
                onTap: () => attemptLogin(context),
              ),

              const SizedBox(height: 25),

              // Register button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member? ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: toggleScreens,
                    child: const Text(
                      "Register Now",
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
