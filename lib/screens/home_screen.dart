import 'package:e_isocomm/services/auth_service.dart';
import 'package:e_isocomm/utils/will_pop_scope_wrapper.dart';
import 'package:e_isocomm/widgets/drawer_wg.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void attemptLogout(BuildContext context) async {
    final authService = AuthService();
    bool shouldSignOut = await authService.confirmSignOut(context);

    if (shouldSignOut) {
      authService.signOut();
      // Navigator.of(context).pushReplacementNamed('/login'); // Arahkan ke login
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScopeWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Home Screen')),
          actions: [
            IconButton(
                onPressed: () => attemptLogout(context),
                icon: const Icon(Icons.logout))
          ],
        ),
        drawer: const DrawerWg(),
      ),
    );
  }
}
