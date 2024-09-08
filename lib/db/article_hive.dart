import 'package:hive/hive.dart';

part 'article_hive.g.dart';

@HiveType(typeId: 0)
class ArticleHive extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? authorId;

  @HiveField(2)
  String img;

  @HiveField(3)
  String title;

  @HiveField(4)
  String description;

  @HiveField(5)
  String content;

  @HiveField(6)
  String authorName;

  @HiveField(7)
  String createdAt;

  @HiveField(8)
  List<dynamic>? likes;

  @HiveField(9)
  bool isDraft;

  @HiveField(10)
  bool isPublished;

  @HiveField(11)
  bool isActive;

  ArticleHive({
    this.id,
    this.authorId,
    required this.img,
    required this.title,
    required this.description,
    required this.content,
    required this.authorName,
    required this.createdAt,
    this.likes,
    required this.isDraft,
    required this.isPublished,
    required this.isActive,
  });
}
