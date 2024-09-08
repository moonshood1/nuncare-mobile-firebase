import 'package:hive/hive.dart';

part 'doctor_hive.g.dart';

@HiveType(typeId: 3)
class DoctorHive extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String firebaseId;

  @HiveField(2)
  String firstName;

  @HiveField(3)
  String lastName;

  @HiveField(4)
  String bio;

  @HiveField(5)
  String sex;

  @HiveField(6)
  String hospital;

  @HiveField(7)
  String speciality;

  @HiveField(8)
  String? otherSpeciality;

  @HiveField(9)
  String university;

  @HiveField(10)
  String countryUniversity;

  @HiveField(11)
  int years;

  @HiveField(12)
  String img;

  @HiveField(13)
  String phone;

  @HiveField(14)
  String district;

  @HiveField(15)
  String region;

  @HiveField(16)
  String city;

  @HiveField(17)
  String address;

  @HiveField(18)
  double lat;

  @HiveField(19)
  double lng;

  @HiveField(20)
  String email;

  @HiveField(21)
  String orderNumber;

  @HiveField(22)
  String promotion;

  @HiveField(23)
  String deviceId;

  @HiveField(24)
  bool isActive;

  DoctorHive({
    this.id,
    required this.firebaseId,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.sex,
    required this.hospital,
    required this.speciality,
    this.otherSpeciality,
    required this.university,
    required this.countryUniversity,
    required this.years,
    required this.img,
    required this.phone,
    required this.district,
    required this.region,
    required this.city,
    required this.address,
    required this.lat,
    required this.lng,
    required this.email,
    required this.orderNumber,
    required this.promotion,
    required this.isActive,
    required this.deviceId,
  });
}
