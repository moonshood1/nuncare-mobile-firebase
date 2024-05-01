class Pharmacy {
  Pharmacy({
    required this.id,
    required this.name,
    required this.city,
    required this.district,
    required this.lng,
    required this.lat,
    required this.phone,
    required this.img,
  });

  String id, img, name, city, district, phone;
  double lng, lat;

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['_id'],
      name: json['name'],
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
      img: json['img'] ?? '',
      phone: json['phone'],
      district: json["district"],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'name': name,
      'lat': lat,
      'lng': lng,
      'phone': phone,
      'district': district,
      'city': city,
    };
  }
}
