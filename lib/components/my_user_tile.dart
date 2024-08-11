import 'package:flutter/material.dart';

class MyUserTile extends StatelessWidget {
  const MyUserTile({
    super.key,
    required this.text,
    required this.onTap,
    this.unreadMessagesCount = 0,
  });

  final String text;
  final void Function()? onTap;
  final int unreadMessagesCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 30,
                  ),
                  Text(text),
                ],
              ),
              unreadMessagesCount > 0
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: Text(
                        unreadMessagesCount.toString(),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
