import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuncare_mobile_firebase/constants/base_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BasicResponse {
  final bool success;
  final String message;

  BasicResponse({
    required this.success,
    required this.message,
  });
}

class AuthService {
  // Instance of auth & firestore

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current User

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInformations(
    String userId,
  ) {
    return _firestore.collection('Users').doc(userId).snapshots();
  }

  // sign in
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

  // sign up

  Future<BasicResponse> signUp(
    String email,
    password,
    firstName,
    lastName,
  ) async {
    try {
      final url = Uri.parse("$baseUrl/auth/register");

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'bio': '',
        'sex': '',
        'hospital': '',
        'speciality': '',
        'years': 0,
        'img': '',
        'cover': '',
        'phone': '',
        'region': '',
        'city': '',
        'address': '',
        'lat': 0,
        'lng': 0,
        'orderNumber': '',
      });

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'email': email,
            'firebaseId': userCredential.user!.uid,
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
    } on FirebaseAuthException catch (e) {
      print("ERROR SIGN UP ");
      print(e);

      if (e.code == 'email-already-in-use') {
        throw Exception("Ce compte existe déjà. Veuillez vous connecter");
      }

      throw Exception(e.code);
    }
  }

  // sign out

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

  // errors
}
