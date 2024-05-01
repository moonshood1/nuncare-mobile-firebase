class Article {
  Article({
    this.id,
    required this.img,
    required this.title,
    required this.description,
    this.authorId,
    required this.createdAt,
    required this.content,
    required this.authorName,
    this.likes,
  });

  String? id, authorId;
  String img, title, description, content, authorName, createdAt;
  List<dynamic>? likes;

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
      likes: List<dynamic>.from(json['likes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'title': title,
      'description': description,
      'content': content,
    };
  }
}
