import 'package:hive/hive.dart';

part 'ad_hive.g.dart';

@HiveType(typeId: 1)
class Ad extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String label;

  @HiveField(2)
  String img;

  @HiveField(3)
  String company;

  @HiveField(4)
  String description;

  @HiveField(5)
  String websiteLink;

  @HiveField(6)
  bool isActive;

  Ad({
    this.id,
    required this.label,
    required this.img,
    required this.company,
    required this.description,
    required this.websiteLink,
    required this.isActive,
  });
}
