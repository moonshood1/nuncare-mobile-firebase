import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/screens/auth/auth_gate.dart';
import 'package:nuncare_mobile_firebase/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then(
    (value) => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: const AuthGate(),
      ),
    ),
  );
}
