class Info {
  Info({
    this.id,
    required this.title,
    required this.message,
    required this.img,
    required this.isActive,
  });

  String? id;
  String title, img, message;
  bool isActive;

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      title: json['title'],
      message: json['message'],
      img: json['img'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'img': img,
      'isActive': isActive,
    };
  }
}
