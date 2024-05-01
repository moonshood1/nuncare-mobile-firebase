import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String receiverName;
  final String message;
  final Timestamp? timestamp;
  final String? messageTime;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.receiverName,
    required this.message,
    this.timestamp,
    this.messageTime,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      senderEmail: json['senderEmail'],
      receiverName: json['receiverName'],
      message: json['message'],
      messageTime: json['messageTime'],
      // timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'message': message,
      'timestamp': timestamp
    };
  }
}
