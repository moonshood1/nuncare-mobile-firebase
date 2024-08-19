import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuncare_mobile_firebase/models/message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Stream<List<Map<String, dynamic>>> getUserStreamExcludingBlockedUsers() {
    final currentUser = _auth.currentUser;

    return _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      final blockedUsersIds = snapshot.docs.map((doc) => doc.id).toList();

      final userSnapshot = await _firestore.collection('Users').get();
      final userData = await Future.wait(
        userSnapshot.docs
            .where((doc) =>
                doc.data()['email'] != currentUser.email &&
                !blockedUsersIds.contains(doc.id))
            .map((doc) async {
          final userData = doc.data();
          final chatroomId = [currentUser.uid, doc.id]..sort();

          final unreadMessagesSnapshot = await _firestore
              .collection('Chat_rooms')
              .doc(chatroomId.join('_'))
              .collection("messages")
              .where('receiverId', isEqualTo: currentUser.uid)
              .where('isRead', isEqualTo: false)
              .get();

          userData['unreadCount'] = unreadMessagesSnapshot.docs.length;

          return userData;
        }).toList(),
      );
      return userData;
    });
  }

  // Stream<List<Map<String, dynamic>>> getUserStreamWithChatrooms() {
  //   final currentUser = _auth.currentUser;

  //   return _firestore
  //       .collection('Users')
  //       .snapshots()
  //       .asyncMap((snapshot) async {
  //     List<String> userIdsWithChatrooms = [];

  //     final allUsers = snapshot.docs.map((doc) => doc.id).toList();

  //     final chatRoomIds = await Future.wait(allUsers
  //         .map((userId) async {
  //           List<String> ids = [currentUser!.uid, userId];
  //           ids.sort();
  //           String chatRoomId = ids.join('_');

  //           final messagesSnapshot = await _firestore
  //               .collection('Chat_rooms')
  //               .doc(chatRoomId)
  //               .collection('messages')
  //               .get();

  //           if (messagesSnapshot.docs.isNotEmpty) {
  //             return userId;
  //           }
  //           return null;
  //         })
  //         .where((id) => id != null)
  //         .toList());

  //     userIdsWithChatrooms = chatRoomIds.whereType<String>().toList();

  //     if (userIdsWithChatrooms.isEmpty) {
  //       return [];
  //     }

  //     final usersSnapshot = await _firestore
  //         .collection('Users')
  //         .where(FieldPath.documentId, whereIn: userIdsWithChatrooms)
  //         .get();

  //     return usersSnapshot.docs.map((doc) {
  //       final user = doc.data();
  //       return user;
  //     }).toList();
  //   });
  // }

  Stream<List<Map<String, dynamic>>> getUserStreamWithChatrooms() {
    final currentUser = _auth.currentUser;

    return _firestore
        .collection('Users')
        .snapshots()
        .asyncMap((snapshot) async {
      List<String> userIdsWithChatrooms = [];

      final allUsers = snapshot.docs.map((doc) => doc.id).toList();

      // Récupérer les IDs des utilisateurs avec des chatrooms ayant des messages
      final chatRoomIds = await Future.wait(allUsers
          .map((userId) async {
            List<String> ids = [currentUser!.uid, userId];
            ids.sort();
            String chatRoomId = ids.join('_');

            final messagesSnapshot = await _firestore
                .collection('Chat_rooms')
                .doc(chatRoomId)
                .collection('messages')
                .get();

            if (messagesSnapshot.docs.isNotEmpty) {
              return userId;
            }
            return null;
          })
          .where((id) => id != null)
          .toList());

      userIdsWithChatrooms = chatRoomIds.whereType<String>().toList();

      if (userIdsWithChatrooms.isEmpty) {
        return [];
      }

      // Récupérer les détails des utilisateurs avec les IDs récupérés
      final usersSnapshot = await _firestore
          .collection('Users')
          .where(FieldPath.documentId, whereIn: userIdsWithChatrooms)
          .get();

      // Ajouter le comptage des messages non lus
      final userData = await Future.wait(
        usersSnapshot.docs.map((doc) async {
          final user = doc.data();
          final chatroomId = [currentUser!.uid, doc.id]..sort();
          final chatRoomDocId = chatroomId.join('_');

          final unreadMessagesSnapshot = await _firestore
              .collection('Chat_rooms')
              .doc(chatRoomDocId)
              .collection("messages")
              .where('receiverId', isEqualTo: currentUser.uid)
              .where('isRead', isEqualTo: false)
              .get();

          user['unreadCount'] = unreadMessagesSnapshot.docs.length;

          return user;
        }).toList(),
      );

      return userData;
    });
  }

  Future<void> sendMessage(String receiverId, message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
      isRead: false,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatroomId = ids.join('_');

    await _firestore
        .collection('Chat_rooms')
        .doc(chatroomId)
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

  Future<void> markMessagesAsRead(String receiverId) async {
    final currentUserId = _auth.currentUser!.uid;

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    final unreadMessagesQuery = _firestore
        .collection('Chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .where('receiverId', isEqualTo: currentUserId)
        .where('isRead', isEqualTo: false);

    final unreadMessagesSnapshot = await unreadMessagesQuery.get();

    for (var doc in unreadMessagesSnapshot.docs) {
      await doc.reference.update({'isRead': true});
    }
  }

  Future<void> reportUser(String messageId, String userId) async {
    final currentUser = _auth.currentUser;

    final report = {
      'reportedBy': currentUser!.uid,
      'messageId': messageId,
      'messageOwnerId': userId,
      'timestamp': FieldValue.serverTimestamp()
    };

    await _firestore.collection('Reports').add(report);
  }

  Future<void> blockUser(String userId) async {
    final currentUser = _auth.currentUser;

    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(userId)
        .set({});
  }

  Future<void> unblockUser(String blockedUserId) async {
    final currentUser = _auth.currentUser;

    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(blockedUserId)
        .delete();
  }

  Stream<List<Map<String, dynamic>>> getBlockedUserStream(String userId) {
    return _firestore
        .collection('Users')
        .doc(userId)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      final blockedUsers = snapshot.docs.map((doc) => doc.id).toList();

      final userDocs = await Future.wait(
        blockedUsers.map(
          (id) => _firestore.collection('Users').doc(id).get(),
        ),
      );

      return userDocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }
}
