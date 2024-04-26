class Notif {
  Notif({
    required this.id,
    required this.img,
    required this.title,
    required this.message,
    required this.link,
  });

  String id, img, title, message, link;

  factory Notif.fromJson(Map<String, dynamic> json) {
    return Notif(
      id: json['_id'],
      title: json['title'],
      message: json['message'],
      img: json['img'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img': img,
      'title': title,
      'message': message,
      'link': link,
    };
  }
}
