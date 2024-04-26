class Chat {
  Chat({this.id, required this.receiverName});

  String? id;
  String receiverName;

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      receiverName: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receiverName': receiverName,
    };
  }
}
