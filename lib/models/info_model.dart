class Info {
  Info({
    this.id,
    required this.title,
    required this.img,
    required this.text,
  });

  String? id;
  String title, img, text;

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      title: json['title'],
      img: json['img'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'title': title,
      'text': text,
    };
  }
}
