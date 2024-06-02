import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/screens/auth/slider_screen.dart';
import 'package:nuncare_mobile_firebase/screens/root_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const RootPageScreen();
          } else {
            return const SliderScreen();
          }
        },
      ),
    );
  }
}
