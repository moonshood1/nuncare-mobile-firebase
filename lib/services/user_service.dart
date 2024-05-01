import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuncare_mobile_firebase/constants/uris.dart';
import 'package:nuncare_mobile_firebase/models/message_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nuncare_mobile_firebase/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Doctor> getInformations() async {
    try {
      final url = Uri.parse("$usersUri/");

      final token = await _auth.currentUser?.getIdToken();

      if (token == null) {
        throw Exception('Token non disponible');
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Doctor doctor = Doctor.fromJson(responseData['user']);

        return doctor;
      } else {
        throw Exception(
          "Erreur lors de la récupération des informations de l'utilisateur",
        );
      }
    } catch (e) {
      throw Exception("Erreur lors de la récupération de l'utilisateur : $e");
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInformations(
    String userId,
  ) {
    return _firestore.collection('Users').doc(userId).snapshots();
  }

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

  Future<List<Message>> getChats() async {
    try {
      final url = Uri.parse("$usersUri/chat-room");

      final token = await _auth.currentUser?.getIdToken();

      if (token == null) {
        throw Exception('Token non disponible');
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> chatsData = responseData['chats'] ?? [];

        final List<Message> chats =
            chatsData.map((data) => Message.fromJson(data)).toList();

        return chats;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération des messages : $e');
    }
  }

  Stream<List<Map<String, dynamic>>> getUserStream() {
    try {
      return _firestore.collection('Users').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          final user = doc.data();

          return user;
        }).toList();
      });
    } catch (error) {
      print(error);
      throw [];
    }
  }

  Future<void> sendMessage(
    String receiverId,
    String message,
    String receiverName,
  ) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverName: receiverName,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await registerChatRoom(receiverId, chatRoomId);

    await _firestore
        .collection('Chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toJson());
  }

  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('Chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Future<void> registerChatRoom(String receiverId, String chatRoomId) async {
    try {
      final url = Uri.parse("$usersUri/chat-room");

      final token = await _auth.currentUser?.getIdToken();

      if (token == null) {
        throw Exception('Token non disponible');
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(
          {
            'chatRoomId': chatRoomId,
            'receiverId': receiverId,
          },
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        return;
      }
    } catch (e) {
      throw Exception("Erreur lors de l'enregistrement du chat room : $e");
    }
  }
}
