import 'package:flutter/material.dart';

class LegalMentionPageScreen extends StatelessWidget {
  const LegalMentionPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;
    double deviceHeight(BuildContext context) =>
        MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mentions légales",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: deviceHeight(context) * 0.08,
          horizontal: deviceWidth(context) * 0.05,
        ),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
