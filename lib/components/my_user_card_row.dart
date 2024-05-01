import 'package:flutter/material.dart';

class MyUserRow extends StatelessWidget {
  const MyUserRow({
    super.key,
    required this.name,
    required this.id,
    required this.img,
    required this.onTap,
  });

  final String name, id, img;
  final void Function()? onTap;

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
              CircleAvatar(
                backgroundImage: NetworkImage(img),
              ),
              Text(name),
              const Icon(
                Icons.arrow_forward,
                size: 30,
              ),
              // const SizedBox(
              //   width: 10,
              // ),
              // Text(id),
            ],
          ),
        ),
      ),
    );
  }
}
