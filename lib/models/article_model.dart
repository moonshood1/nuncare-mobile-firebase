class Article {
  Article({
    this.id,
    required this.img,
    required this.title,
    required this.description,
    this.authorId,
    this.createdAt,
    required this.content,
    required this.authorName,
  });

  String? id, authorId, createdAt;
  String img, title, description, content, authorName;

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json["uid"],
      img: json['img'],
      title: json['title'],
      authorId: json['authorId '],
      authorName: json['authorName'],
      description: json['description'],
      createdAt: json['createdAt'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'title': title,
      'authorId': authorId,
      'authorName': authorName,
      'description': description,
      "createdAt": createdAt,
      'content': content,
    };
  }
}
