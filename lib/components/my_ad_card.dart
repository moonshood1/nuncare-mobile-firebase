import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/models/ad_model.dart';

class AdCard extends StatelessWidget {
  const AdCard({super.key, required this.ad});

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          ad.img,
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
