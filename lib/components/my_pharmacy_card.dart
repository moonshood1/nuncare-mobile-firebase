import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/models/pharmacy_model.dart';

class MyPharmacyCard extends StatelessWidget {
  const MyPharmacyCard({required this.pharmacy, super.key});

  final Pharmacy pharmacy;

  @override
  Widget build(BuildContext context) {
    return Text("My pharmacy :${pharmacy.name}");
  }
}
