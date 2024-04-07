import 'package:flutter/material.dart';

class MyChatBubble extends StatelessWidget {
  const MyChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  final bool isCurrentUser;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isCurrentUser
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.tertiary,
      ),
      child: Text(
        message,
        style: TextStyle(color: isCurrentUser ? Colors.white : Colors.black),
      ),
    );
  }
}
