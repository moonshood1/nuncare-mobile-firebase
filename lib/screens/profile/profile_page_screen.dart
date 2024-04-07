import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_skeleton.dart';

class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MySkeleton(
                height: 170,
                width: double.infinity,
              ),
              SizedBox(
                height: 30,
              ),
              MySkeleton(
                height: 40,
                width: double.infinity,
              ),
              SizedBox(
                height: 30,
              ),
              MySkeleton(
                height: 25,
                width: double.infinity,
              ),
              SizedBox(
                height: 10,
              ),
              MySkeleton(
                height: 25,
                width: double.infinity,
              ),
              SizedBox(
                height: 10,
              ),
              MySkeleton(
                height: 25,
                width: double.infinity,
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 10,
                  children: [
                    MySkeleton(
                      height: 170,
                      width: 170,
                    ),
                    MySkeleton(
                      height: 170,
                      width: 170,
                    ),
                    MySkeleton(
                      height: 170,
                      width: 170,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MySkeleton(
                height: 25,
                width: double.infinity,
              ),
              SizedBox(
                height: 10,
              ),
              MySkeleton(
                height: 25,
                width: double.infinity,
              ),
              SizedBox(
                height: 10,
              ),
              MySkeleton(
                height: 25,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
