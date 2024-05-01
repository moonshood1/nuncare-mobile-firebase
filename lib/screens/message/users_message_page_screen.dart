import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_user_tile.dart';
import 'package:nuncare_mobile_firebase/screens/message/chat_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';

class UserMessagePageScreen extends StatelessWidget {
  UserMessagePageScreen({super.key});

  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Nouveau message',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: _buildUserList(),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _userService.getUserStream(),
      builder: (ctx, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Erreur au chargement des docteurs");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MyLoadingCirle();
        }

        if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "Aucun docteur pour l'instant",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          );
        }

        return ListView(
          children: snapshot.data!
              .map(
                (userData) => _buildUserListItem(userData, ctx),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return MyUserTile(
        text: "${userData["firstName"]} ${userData["lastName"]}",
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ChatPageScreen(
              receiverName: "${userData["firstName"]} ${userData["lastName"]}",
              receiverId: userData['uid'],
              // receiverEmail: userData["email"],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
