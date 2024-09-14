import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCommentTile extends StatelessWidget {
  MyCommentTile({
    super.key,
    required this.comment,
    required this.authorName,
    this.createdAt,
  });

  final String comment, authorName;
  String? createdAt;

  @override
  Widget build(BuildContext context) {
    DateTime inputDate = DateTime.parse(createdAt!);
    String formattedDate = DateFormat('dd-MM-yyyy - HH:mm').format(inputDate);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.2,
              blurRadius: 0.5,
              offset: const Offset(0, 0.5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 30,
                    ),
                    Text(
                      authorName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              comment,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
