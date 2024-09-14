import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_chat_drawer.dart';
import 'package:nuncare_mobile_firebase/components/my_drawer.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_user_tile.dart';
import 'package:nuncare_mobile_firebase/screens/message/chat_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/chat_service.dart';

class MessagePageScreen extends StatefulWidget {
  const MessagePageScreen({super.key});

  @override
  State<MessagePageScreen> createState() => _MessagePageScreenState();
}

class _MessagePageScreenState extends State<MessagePageScreen> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Messagerie',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
      drawer: MyChatDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      // stream: _chatService.getUserStreamExcludingBlockedUsers(),
      stream: _chatService.getUserStreamWithChatrooms(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Text(
                "Erreur de récupération des utilisateurs",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: MyLoadingCirle(),
            // child: MyWaveCircleLoading(),
          );
        }

        if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "Aucune conversation pour l'instant",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          );
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return MyUserTile(
        text: "${userData["email"]}",
        onTap: () async {
          await _chatService.markMessagesAsRead(userData['uid']);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => ChatPageScreen(
                receiverName: "${userData["email"]}",
                receiverId: userData['uid'],
              ),
            ),
          );
        },
        unreadMessagesCount: userData['unreadCount'],
      );
    } else {
      return Container();
    }
  }
}
