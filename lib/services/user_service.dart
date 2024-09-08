import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuncare_mobile_firebase/constants/uris.dart';
import 'package:nuncare_mobile_firebase/models/article_model.dart';
import 'package:nuncare_mobile_firebase/models/message_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';

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

  Future<BasicResponse> updateUserInformations(
      String field, dynamic value) async {
    try {
      final url = Uri.parse("$usersUri?field=$field");

      final token = await _auth.currentUser?.getIdToken();

      if (token == null) {
        throw Exception('Token non disponible');
      }

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(
          {
            'value': value,
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
      print("Erreur modification informatioons : $e");

      rethrow;
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

    // Message newMessage = Message(
    //   senderId: currentUserId,
    //   senderEmail: currentUserEmail,
    //   receiverName: receiverName,
    //   receiverId: receiverId,
    //   message: message,
    //   timestamp: timestamp,
    // );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // await registerChatRoom(receiverId, chatRoomId);
    await registerChatRoomInFireStore(
      currentUserId,
      chatRoomId,
      receiverId,
      receiverName,
    );
    await registerChatRoomInFireStore(
      receiverId,
      chatRoomId,
      currentUserId,
      currentUserEmail,
    );

    await _firestore
        .collection('Chat_rooms')
        .doc(chatRoomId)
        .collection('messages');
    // .add(newMessage.toJson());
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

  Future<void> registerChatRoomInFireStore(
    String userId,
    String chatRoomId,
    String receiverId,
    String receiverName,
  ) async {
    await _firestore
        .collection('Users')
        .doc(userId)
        .collection('chatRooms')
        .doc(chatRoomId)
        .set({
      'chatRoomId': chatRoomId,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'lastUpdated': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getUserChatRooms(String userId) {
    return _firestore
        .collection('Users')
        .doc(userId)
        .collection('chatRooms')
        .orderBy('lastUpdated', descending: true)
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

  Future<List<Article>> getUserArticles() async {
    try {
      final token = await _auth.currentUser?.getIdToken();

      if (token == null) {
        throw Exception('Token non disponible');
      }

      final url = Uri.parse("$usersUri/articles");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> articlesData = responseData['articles'] ?? [];

        final List<Article> articles =
            articlesData.map((data) => Article.fromJson(data)).toList();

        return articles;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception(
        "Erreur lors de la récupération des  de l'utilisateur : $error",
      );
    }
  }

  Future<BasicResponse> createArticle(
    String title,
    String description,
    String content,
    String img,
  ) async {
    try {
      final token = await _auth.currentUser?.getIdToken();

      if (token == null) {
        throw Exception('Token non disponible');
      }

      final url = Uri.parse("$usersUri/articles-create");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(
          {
            'title': title,
            'description': description,
            'content': content,
            'img': img
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
    } catch (error) {
      throw Exception(
        "Erreur lors de création de l'article : $error",
      );
    }
  }

  Future<BasicResponse> updateBulkInformations(
    Map<String, String> userData,
  ) async {
    try {
      final url = Uri.parse("$usersUri/update-informations");

      final token = await _auth.currentUser?.getIdToken();

      if (token == null) {
        throw Exception('Token non disponible');
      }

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(userData),
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
      print('Erreur modification profil: $e');
      rethrow;
    }
  }

  Future<void> likeArticle(String articleId) async {
    try {
      final url = Uri.parse("$usersUri/article-like");

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
            'id': articleId,
          },
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        return;
      }
    } catch (e) {
      throw Exception("Erreur lors de l'enregistrement du like : $e");
    }
  }

  Future<void> commentArticle(String articleId, String comment) async {
    try {
      final url = Uri.parse("$usersUri/article-comment");

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
            'id': articleId,
            'comment': comment,
          },
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        return;
      }
    } catch (e) {
      throw Exception("Erreur lors de l'enregistrement du commentaire : $e");
    }
  }
}
