import 'package:e_isocomm/services/auth_service.dart';
import 'package:e_isocomm/themes/theme_provider.dart';
import 'package:e_isocomm/utils/will_pop_scope_wrapper.dart';
import 'package:e_isocomm/widgets/drawer_wg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void attemptLogout(BuildContext context) {
    final authService = AuthService();

    authService.signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScopeWrapper(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.grey,
          title: const Center(child: Text('Settings Screen')),
          actions: [
            IconButton(
                onPressed: () => attemptLogout(context),
                icon: const Icon(Icons.logout))
          ],
        ),
        drawer: const DrawerWg(),
        body: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dark Mode'),
              CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .isDarkMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
