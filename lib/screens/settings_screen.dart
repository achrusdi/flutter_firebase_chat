import 'package:e_isocomm/services/auth_service.dart';
import 'package:e_isocomm/utils/will_pop_scope_wrapper.dart';
import 'package:e_isocomm/widgets/drawer_wg.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void attemptLogout() {
    final authService = AuthService();

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScopeWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Settings Screen')),
          actions: [
            IconButton(onPressed: attemptLogout, icon: const Icon(Icons.logout))
          ],
        ),
        drawer: const DrawerWg(),
      ),
    );
  }
}
