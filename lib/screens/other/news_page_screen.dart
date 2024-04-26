import 'package:flutter/material.dart';

class NewsPageScreen extends StatelessWidget {
  const NewsPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Actualités",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "Aucune actualité pour l'instant",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
