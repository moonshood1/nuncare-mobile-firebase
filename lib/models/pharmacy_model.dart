class Pharmacy {
  Pharmacy({
    required this.id,
    required this.name,
    required this.city,
    required this.region,
    required this.lng,
    required this.lat,
    required this.phone,
    required this.img,
  });

  String id, img, name, city, region, phone;
  double lng, lat;

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['_id'],
      name: json['name'],
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
      img: json['img'] ?? '',
      phone: json['phone'],
      region: json["region"],
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
      'region': region,
      'city': city,
    };
  }
}
