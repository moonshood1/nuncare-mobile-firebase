import 'package:nuncare_mobile_firebase/models/message_model.dart';

class Chat {
  Chat({
    required this.id,
    required this.participants,
    required this.messages,
  });

  String? id;
  List<String>? participants;
  List<Message>? messages;

  // Méthode pour convertir un Chat en format JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
      'messages': messages?.map((message) => message.toJson()).toList(),
    };
  }

  // Méthode pour créer un Chat à partir d'un JSON
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      participants: List<String>.from(json['participants']),
      messages: List<Message>.from(
        json['messages'].map(
          (messageJson) => Message.fromJson(messageJson),
        ),
      ),
    );
  }
}
