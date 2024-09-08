import 'package:flutter/material.dart';

class MyInfoTile extends StatelessWidget {
  const MyInfoTile({super.key, required this.text, required this.title});

  final String text, title;

  void showTileInfo(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        content: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => showTileInfo(context, title, text),
                  child: Text(
                    text != "" ? text : "-",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ),
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
