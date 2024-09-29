import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/services/chat_service.dart';
import 'package:nuncare_mobile_firebase/themes/theme_provider.dart';
import 'package:nuncare_mobile_firebase/utils/convert_timestamp.dart';
import 'package:provider/provider.dart';

class MyChatBubble extends StatelessWidget {
  const MyChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageId,
    required this.userId,
    required this.messageTime,
  });

  final bool isCurrentUser;
  final String message, messageId, userId;
  final Timestamp messageTime;

  void _showOptions(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text(
                  "Signaler",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onTap: () {
                  _reportContent(context, messageId, userId);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.block),
                title: const Text(
                  "Bloquer",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _blockUser(context, userId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text(
                  "Annuler",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  void _reportContent(BuildContext context, String messageId, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Signaler le message'),
        content: const Text(
          'Vous etes sur de vouloir signaler ce message ?',
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
              ChatService().reportUser(messageId, userId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Message signalé"),
                ),
              );
            },
            child: const Text('Signaler'),
          ),
        ],
      ),
    );
  }

  void _blockUser(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Bloquer l'utilisateur"),
        content: const Text(
          'Vous etes sur de vouloir bloquer cet utilisateur ?',
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
              ChatService().blockUser(userId);
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Utilisateur bloqué"),
                ),
              );
            },
            child: const Text('Bloquer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = convertTimestamp(messageTime);

    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return GestureDetector(
      onLongPress: () {
        if (!isCurrentUser) {
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isCurrentUser
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.tertiary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isCurrentUser ? Colors.white : Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              formattedTime,
              style: TextStyle(
                fontSize: 8,
                color: isCurrentUser ? Colors.white : Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
