import 'package:hive/hive.dart';

part 'medecine_hive.g.dart';

@HiveType(typeId: 2)
class MedecineHive extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String img;

  @HiveField(2)
  String name;

  @HiveField(3)
  String category;

  @HiveField(4)
  String group;

  @HiveField(5)
  String dci;

  @HiveField(6)
  String regime;

  @HiveField(7)
  int price;

  MedecineHive({
    required this.id,
    required this.name,
    required this.group,
    required this.dci,
    required this.regime,
    required this.category,
    required this.price,
    required this.img,
  });
}
