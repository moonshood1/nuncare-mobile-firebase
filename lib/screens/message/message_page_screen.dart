import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_chat_tile.dart';
import 'package:nuncare_mobile_firebase/components/my_drawer.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/models/message_model.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';

class MessagePageScreen extends StatefulWidget {
  const MessagePageScreen({super.key});

  @override
  State<MessagePageScreen> createState() => _MessagePageScreenState();
}

class _MessagePageScreenState extends State<MessagePageScreen> {
  final UserService _userService = UserService();

  List<Message> messages = [];
  var _isLoading = false;

  void getMessagesFromStore() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Message> response = await _userService.getChats();

      setState(() {
        messages = response;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getMessagesFromStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget messagesContent = const Center(
      child: Text(
        "Aucune conversation pour l'instant",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    );

    if (_isLoading && messages.isEmpty) {
      messagesContent = const Center(
        child: MyLoadingCirle(),
      );
    }

    if (messages.isNotEmpty) {
      messagesContent = ListView.builder(
        itemCount: messages.length,
        itemBuilder: (BuildContext ctx, int index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyChatTile(
            message: messages[index],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Messagerie',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: messagesContent,
      ),
    );
  }
}
