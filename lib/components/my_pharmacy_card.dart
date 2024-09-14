import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/models/pharmacy_model.dart';

class MyPharmacyCard extends StatelessWidget {
  const MyPharmacyCard({required this.pharmacy, super.key});

  final Pharmacy pharmacy;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: pharmacy.isGuard // Vérifie si isGuard est vrai
          ? Banner(
              message: "Garde",
              color: Colors.green,
              location: BannerLocation.bottomEnd,
              child: _buildPharmacyContainer(),
            )
          : _buildPharmacyContainer(), // Affiche directement le conteneur sans la bannière
    );
  }

  Widget _buildPharmacyContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.2,
            blurRadius: 0.5,
            offset: const Offset(0, 0.5),
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pharmacy.name,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            pharmacy.phone,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w200,
              fontSize: 10,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            pharmacy.address,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 10,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            "${pharmacy.section} ${pharmacy.area}",
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 7,
            ),
          ),
        ],
      ),
    );
  }
}
