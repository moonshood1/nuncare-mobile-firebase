import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nuncare_mobile_firebase/constants/uris.dart';

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
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserCredential> signIn(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("ERROR SIGN IN ");
      print(e);
      throw Exception(e.code);
    }
  }

  Future<BasicResponse> signUp(
    String email,
    password,
    firstName,
    lastName,
  ) async {
    try {
      final url = Uri.parse('$authUri/register');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'email': email,
            'firstName': firstName,
            'lastName': lastName,
            'password': password,
          },
        ),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
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
    return await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("ERROR SENDING PASSWORD RESET ");
      print(e);
      throw Exception(e.code);
    }
  }
}
