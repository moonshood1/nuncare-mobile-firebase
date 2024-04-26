class Medecine {
  Medecine({
    required this.id,
    required this.name,
    required this.group,
    required this.dci,
    required this.regime,
    required this.category,
    required this.price,
    required this.img,
  });

  String id, img, name, category, group, dci, regime;
  int price;

  factory Medecine.fromJson(Map<String, dynamic> json) {
    return Medecine(
      id: json['_id'],
      group: json['group'],
      dci: json['dci'],
      regime: json['regime'],
      img: json['img'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img': img,
      'name': name,
      'group': group,
      'regime': regime,
      'dci': dci,
      'category': category,
      'price': price,
    };
  }
}
