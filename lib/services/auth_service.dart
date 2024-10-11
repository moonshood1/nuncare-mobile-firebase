import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nuncare_mobile_firebase/constants/uris.dart';
import 'package:nuncare_mobile_firebase/services/notification_service.dart';

class BasicResponse {
  final bool success;
  final String message;

  BasicResponse({
    required this.success,
    required this.message,
  });
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserCredential> signIn(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      NotificationService().setupTokenListeners();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("ERROR SIGN IN ");
      print(e);
      throw Exception(e.code);
    }
  }

  Future<BasicResponse> signUp(Map<String, String> userData) async {
    try {
      final url = Uri.parse('$authUri/register');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(userData),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        NotificationService().setupTokenListeners();

        return BasicResponse(
          success: responseData['success'],
          message: responseData['message'],
        );
      } else {
        String errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      print('error inscription $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    String? userId = _auth.currentUser?.uid;

    if (userId != null) {
      await NotificationService().clearTokenOnLogout(userId);
    }

    return await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("error reset password ");
      print(e);
      throw Exception(e.code);
    }
  }

  Future<void> setupPushNotifications() async {
    try {
      await _fcm.requestPermission();

      final token = await _fcm.getToken();
      if (token != null) {
        print('FCM token : $token');
        await sendFCMTokenToServer(token);
      }
    } catch (err) {
      print('error getting fcm $err');
    }
  }

  Future<void> sendFCMTokenToServer(String token) async {
    try {
      final userToken = await _auth.currentUser?.getIdToken();

      if (userToken == null) {
        throw Exception('Token non disponible');
      }

      final url = Uri.parse('$authUri/store-fcm-token');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: json.encode({'token': token}),
      );

      if (response.statusCode == 200) {
        print('Token stored successfully');
      } else {
        print('Failed to store token: ${response.statusCode}');
      }
    } catch (err) {
      print('error storing fcm token $err');
    }
  }

  Future<void> deleteAccount() async {
    User? user = getCurrentUser();

    if (user != null) {
      await _firestore.collection('Users').doc(user.uid).delete();

      await user.delete();
    }
  }
}
