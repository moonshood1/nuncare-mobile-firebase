import 'package:flutter/material.dart';

class MyLoadingCirle extends StatelessWidget {
  const MyLoadingCirle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

void myLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    },
  );
}
