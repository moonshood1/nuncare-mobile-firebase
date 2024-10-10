import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_user_tile.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/chat_service.dart';

class BlockedUsersPageScreen extends StatelessWidget {
  BlockedUsersPageScreen({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  void _showUnblockBox(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Débloquer l'utilisateur"),
        content: const Text(
          'Vous etes sur de vouloir débloquer cet utilisateur ?',
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              chatService.unblockUser(userId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Utilisateur debloqué"),
                ),
              );
            },
            child: const Text('Débloquer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String userId = authService.getCurrentUser()!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Utilisateurs bloqués',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
      body: _buildUserList(userId),
    );
  }

  Widget _buildUserList(String userId) {
    return StreamBuilder(
      stream: chatService.getBlockedUserStream(userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Text(
                "Erreur de récupération des utilisateurs bloqués",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: MyLoadingCirle(),
          );
        }

        final blockedUsers = snapshot.data ?? [];

        if (blockedUsers.isEmpty) {
          return const Center(
            child: Text(
              "Aucun utilisateur bloqué pour l'instant ",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          );
        }

        return ListView.builder(
          itemCount: blockedUsers.length,
          itemBuilder: (context, index) {
            final user = blockedUsers[index];
            return MyUserTile(
              text: user['email'],
              onTap: () => _showUnblockBox(context, user['uid']),
            );
          },
        );
      },
    );
  }
}
