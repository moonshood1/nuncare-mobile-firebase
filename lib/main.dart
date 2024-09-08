import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nuncare_mobile_firebase/db/ad_hive.dart';
import 'package:nuncare_mobile_firebase/db/article_hive.dart';
import 'package:nuncare_mobile_firebase/db/medecine_hive.dart';
import 'package:nuncare_mobile_firebase/screens/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nuncare_mobile_firebase/services/notification_service.dart';
import 'package:nuncare_mobile_firebase/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(ArticleHiveAdapter());
  Hive.registerAdapter(AdAdapter());
  Hive.registerAdapter(MedecineHiveAdapter());

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  final noti = NotificationService();

  await noti.requestPermission();
  noti.setupInteractions();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then(
    (value) => runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('handling a background message ${message.messageId}');
  print('Message data ${message.data}');
  print('Message notification ${message.notification?.title}');
  print('handling notification ${message.notification?.body}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      // home: const AuthGate(),
      initialRoute: '/',
      routes: {
        "/": (context) => const AuthGate(),
      },
    );
  }
}
