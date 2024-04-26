import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic> updateUserInformations(
      String field, String newValue, String userId) async {
    try {
      await _firestore
          .collection('Users')
          .doc(userId)
          .update({field: newValue});

      return;
    } on FirebaseAuthException catch (e) {
      print("ERROR UPDATING USER DATA ");
      print(e);

      throw Exception(e.code);
    }
  }
}
