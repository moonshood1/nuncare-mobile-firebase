import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_skeleton.dart';

class AnnuaryPageScreen extends StatelessWidget {
  const AnnuaryPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Annuaire',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MySkeleton(
              height: 45,
              width: double.infinity,
            ),
            SizedBox(
              height: 20,
            ),
            MySkeleton(
              height: 25,
              width: 300,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MySkeleton(
                  height: 160,
                  width: 160,
                ),
                MySkeleton(
                  height: 160,
                  width: 160,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MySkeleton(
                  height: 160,
                  width: 160,
                ),
                MySkeleton(
                  height: 160,
                  width: 160,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
