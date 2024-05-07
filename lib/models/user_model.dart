class Doctor {
  String? id;
  String firebaseId;
  String firstName;
  String lastName;
  String bio;
  String sex;
  String hospital;
  String speciality;
  int years;
  String img;
  String phone;
  String city;
  String address;
  double lng;
  double lat;
  String email;
  String orderNumber;
  String deviceId;
  bool isActive;

  // city: ,
  // address: ,
  // lat
  // lng

  Doctor({
    this.id,
    required this.firebaseId,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.sex,
    required this.hospital,
    required this.speciality,
    required this.years,
    required this.img,
    required this.phone,
    required this.city,
    required this.address,
    required this.lat,
    required this.lng,
    required this.email,
    required this.orderNumber,
    required this.isActive,
    required this.deviceId,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'],
      firebaseId: json['firebaseId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      bio: json['bio'] ?? '',
      sex: json['sex'] ?? '',
      hospital: json['hospital'] ?? '',
      speciality: json['speciality'],
      years: json['years'] ?? 0,
      img: json['img'] ?? '',
      phone: json['phone'],
      city: json['city'],
      address: json['address'],
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
      email: json['email'],
      orderNumber: json['orderNumber'],
      isActive: json['isActive'],
      deviceId: json['deviceId'],
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
      'phone': phone,
      'city': city,
      'address': address,
      'lat': lat,
      'lng': lng,
      'email': email,
      'orderNumber': orderNumber,
      'isActive': isActive,
    };
  }

  factory Doctor.defaultDoctor() {
    return Doctor(
      id: '',
      firebaseId: '',
      firstName: '',
      lastName: '',
      bio: '',
      sex: '',
      hospital: '',
      speciality: '',
      years: 0,
      img: '',
      phone: '',
      city: '',
      address: '',
      lat: 0,
      lng: 0,
      email: '',
      orderNumber: '',
      isActive: true,
      deviceId: '',
    );
  }
}
