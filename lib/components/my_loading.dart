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

class MyLoadingDialog extends StatelessWidget {
  const MyLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Chargement ...');
  }
}
