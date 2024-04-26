import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    this.onPressed,
  });

  final String text, sectionName;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey[500],
                ),
              )
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}
