import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _messageStreamController = BehaviorSubject<RemoteMessage>();

  Future<void> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Notification permission granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("Notification permission provisional ");
    } else {
      print("Notification permission declined");
    }
  }

  void setupInteractions() {
    FirebaseMessaging.onMessage.listen((event) {
      print("Got a message whilst in the foreground");

      print('Message data : ${event.data}');

      _messageStreamController.sink.add(event);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('Message clicked');
    });
  }

  void dispose() {
    _messageStreamController.close();
  }

  void setupTokenListeners() {
    FirebaseMessaging.instance
        .getToken()
        .then((token) => saveTokenToDatabase(token));

    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  void saveTokenToDatabase(String? token) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      FirebaseFirestore.instance.collection('Users').doc(userId).set(
        {
          'fcmToken': token,
        },
        SetOptions(
          merge: true,
        ),
      );
    }

    // await
  }

  Future<void> clearTokenOnLogout(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .update({'fcmToken': FieldValue.delete()});

      print('Token cleared');
    } catch (e) {
      print('Failed to clear token $e');
    }
  }
}
