import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/models/medecine_model.dart';

class MyMedecineCard extends StatelessWidget {
  const MyMedecineCard({required this.medecine, super.key});

  final Medecine medecine;

  @override
  Widget build(BuildContext context) {
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
            blurRadius: 1,
            offset: const Offset(0, 1),
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            medecine.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            medecine.dci,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 10,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            medecine.group,
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
            medecine.category,
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
