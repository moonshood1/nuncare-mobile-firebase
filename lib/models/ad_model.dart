class Ad {
  Ad({
    this.id,
    required this.label,
    required this.img,
    required this.company,
    required this.description,
    required this.websiteLink,
    required this.isActive,
  });

  String? id;
  String label, img, company, description, websiteLink;
  bool isActive;

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      img: json['img'],
      label: json['label'],
      company: json['company'],
      description: json['description'],
      websiteLink: json['websiteLink'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'img': img,
      'company': company,
      'websiteLink': websiteLink,
      'description': description,
      "isActive": isActive
    };
  }
}
