import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_user_tile.dart';
import 'package:nuncare_mobile_firebase/screens/message/chat_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/chat_service.dart';

class MessagePageScreen extends StatelessWidget {
  MessagePageScreen({super.key});

  // chat & auth service

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messagerie',
          style: TextStyle(color: Colors.white),
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
      stream: _chatService.getUserStream(),
      builder: (ctx, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MyLoadingCirle();
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
    // display all user except the current one

    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return MyUserTile(
        text: userData["email"],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ChatPageScreen(
              receiverId: userData['uid'],
              receiverEmail: userData["email"],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
