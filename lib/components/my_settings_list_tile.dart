import 'package:flutter/material.dart';

class MySettingsListTile extends StatelessWidget {
  const MySettingsListTile({
    super.key,
    required this.title,
    required this.color,
    required this.action,
    required this.textColor,
  });

  final Color color, textColor;
  final String title;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: textColor,
            ),
          ),
          action,
        ],
      ),
    );
  }
}
