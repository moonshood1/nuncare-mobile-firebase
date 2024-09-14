class Pharmacy {
  Pharmacy({
    this.id,
    required this.name,
    required this.section,
    required this.area,
    required this.lng,
    required this.lat,
    required this.phone,
    required this.address,
    required this.img,
    required this.owner,
    required this.isGuard,
    required this.guardPeriod,
  });

  String? id;
  String img, name, area, section, phone, owner, guardPeriod, address;
  double lng, lat;
  bool isGuard;

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['_id'],
      name: json['name'],
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
      img: json['img'] ?? '',
      phone: json['phone'],
      section: json["section"],
      area: json['area'],
      address: json['address'],
      owner: json['owner'],
      isGuard: json['isGuard'],
      guardPeriod: json['guardPeriod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'name': name,
      'lat': lat,
      'lng': lng,
      'phone': phone,
      'section': section,
      'area': area,
      'address': address,
      'owner': owner
    };
  }
}
