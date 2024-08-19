import 'package:flutter/material.dart';

class MyInfoTile extends StatelessWidget {
  const MyInfoTile({super.key, required this.text, required this.title});

  final String text, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              Text(
                text != "" ? text : "-",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
