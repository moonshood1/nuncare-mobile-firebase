class Comment {
  Comment({
    this.id,
    required this.author,
    required this.comment,
    required this.authorName,
    required this.createdAt,
    required this.article,
  });

  String? id;
  String author, comment, authorName, createdAt, article;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json["_id"],
      author: json['author'],
      authorName: json['authorName'],
      createdAt: json['createdAt'],
      comment: json['comment'],
      article: json['article'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
    };
  }
}
