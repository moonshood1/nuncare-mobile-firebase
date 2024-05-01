import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_chat_bubble.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';

class ChatPageScreen extends StatefulWidget {
  const ChatPageScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  final String receiverId, receiverName;

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  final TextEditingController _messageController = TextEditingController();

  final UserService _userService = UserService();
  final AuthService _auth = AuthService();

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    if (_messageController.text.trim().isEmpty) {
      return;
    }
    await _userService.sendMessage(
        widget.receiverId, _messageController.text, widget.receiverName);
    _messageController.clear();
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(
          widget.receiverName,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput(context)
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _auth.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _userService.getMessages(senderId, widget.receiverId),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return const Text("Erreur lors du chargement des messages");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MyLoadingCirle();
        }

        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == _auth.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          MyChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
        ],
      ),
    );
  }

  Widget _buildUserInput(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: MyTextField(
              controller: _messageController,
              obscureText: false,
              focusNode: myFocusNode,
              isHidden: false,
              labelText: "Ecrivez votre message",
              validator: (value) {
                return null;
              },
              autoCorrect: true,
              keyboardType: TextInputType.text,
              icon: Icons.message,
              textCapitalization: TextCapitalization.none,
            ),
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: Icon(
            Icons.send,
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }
}
