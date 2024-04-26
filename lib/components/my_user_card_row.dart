import 'package:flutter/material.dart';

class MyUserCardRow extends StatelessWidget {
  const MyUserCardRow({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15,
        ),
      ),
    );
  }
}
