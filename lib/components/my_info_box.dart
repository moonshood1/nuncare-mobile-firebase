import 'package:flutter/material.dart';

class MyInfoBox extends StatelessWidget {
  const MyInfoBox({
    super.key,
    required this.text,
    required this.sectionName,
  });

  final String text, sectionName;
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
              Expanded(
                child: Text(
                  sectionName,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
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
