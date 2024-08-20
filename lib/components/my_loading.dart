import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

class MyWaveCircleLoading extends StatelessWidget {
  const MyWaveCircleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      size: 40,
      color: Theme.of(context).colorScheme.primary,
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
