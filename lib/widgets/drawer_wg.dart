import 'package:e_isocomm/screens/home_screen.dart';
import 'package:e_isocomm/screens/settings_screen.dart';
import 'package:e_isocomm/services/auth_service.dart';
import 'package:flutter/material.dart';

class DrawerWg extends StatelessWidget {
  const DrawerWg({super.key});

  void attemptLogout(BuildContext context) async {
    final authService = AuthService();
    bool shouldSignOut = await authService.confirmSignOut(context);

    if (shouldSignOut) {
      authService.signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  iconColor: Theme.of(context).colorScheme.primary,
                  title: const Text("Home"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  iconColor: Theme.of(context).colorScheme.primary,
                  title: const Text("Settings"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SettingsScreen()));

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()),
                      (Route<dynamic> route) => false,
                    );

                    // String? currentRouteName =
                    //     ModalRoute.of(context)?.settings.name;
                    // print(currentRouteName);

                    // Navigator.pop(context);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SettingsScreen()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 20),
            child: ListTile(
              iconColor: Theme.of(context).colorScheme.primary,
              title: const Text("Logout"),
              leading: const Icon(Icons.logout),
              onTap: () => attemptLogout(context),
            ),
          ),
        ],
      ),
    );
  }
}
