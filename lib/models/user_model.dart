import 'package:firebase_auth/firebase_auth.dart';

class Doctor {
  String id;
  String firstName;
  String lastName;
  String bio;
  String sex;
  String hospital;
  String speciality;
  int years;
  String img;
  String cover;
  String phone;
  String region;
  String city;
  String address;
  double lng;
  double lat;
  String email;
  String password;
  String orderNumber;
  bool isActive;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.sex,
    required this.hospital,
    required this.speciality,
    required this.years,
    required this.img,
    required this.cover,
    required this.phone,
    required this.region,
    required this.city,
    required this.address,
    required this.lat,
    required this.lng,
    required this.email,
    required this.password,
    required this.orderNumber,
    required this.isActive,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      bio: json['bio'] ?? '',
      sex: json['sex'] ?? '',
      hospital: json['hospital'] ?? '',
      speciality: json['speciality'],
      years: json['years'] ?? 0,
      img: json['img'] ?? '',
      cover: json['cover'] ?? '',
      phone: json['phone'],
      region: json['region'],
      city: json['city'],
      address: json['address'],
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
      email: json['email'],
      password: json['password'],
      orderNumber: json['orderNumber'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'bio': bio,
      'sex': sex,
      'hospital': hospital,
      'speciality': speciality,
      'years': years,
      'img': img,
      'cover': cover,
      'phone': phone,
      'region': region,
      'city': city,
      'address': address,
      'lat': lat,
      'lng': lng,
      'email': email,
      'password': password,
      'orderNumber': orderNumber,
      'isActive': isActive,
    };
  }

  factory Doctor.defaultDoctor() {
    return Doctor(
      id: '',
      firstName: '',
      lastName: '',
      bio: '',
      sex: '',
      hospital: '',
      speciality: '',
      years: 0,
      img: '',
      cover: '',
      phone: '',
      region: '',
      city: '',
      address: '',
      lat: 0,
      lng: 0,
      email: '',
      password: '',
      orderNumber: '',
      isActive: true,
    );
  }
}
