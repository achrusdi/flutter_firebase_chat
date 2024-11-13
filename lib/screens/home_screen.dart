import 'package:e_isocomm/screens/chat_screen.dart';
import 'package:e_isocomm/services/auth_service.dart';
import 'package:e_isocomm/services/chat_service.dart';
import 'package:e_isocomm/utils/will_pop_scope_wrapper.dart';
import 'package:e_isocomm/widgets/drawer_wg.dart';
import 'package:e_isocomm/widgets/user_tile_wg.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // chat and auth service
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  void attemptLogout(BuildContext context) async {
    final authService = AuthService();
    bool shouldSignOut = await authService.confirmSignOut(context);

    if (shouldSignOut) {
      authService.signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScopeWrapper(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.grey,
          title: const Center(child: Text('Home Screen')),
          actions: [
            IconButton(
                onPressed: () => attemptLogout(context),
                icon: const Icon(Icons.logout))
          ],
        ),
        drawer: const DrawerWg(),
        body: _buildUserList(),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != authService.getCurrentUser()?.email) {
      return UserTileWg(
          text: userData['email'],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          receiverEmail: userData['email'],
                          receiverId: userData['uid'],
                        )));
          });
    }

    return Container();
  }
}
