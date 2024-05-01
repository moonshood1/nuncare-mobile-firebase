import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/models/medecine_model.dart';

class MyMedecineCard extends StatelessWidget {
  const MyMedecineCard({required this.medecine, super.key});

  final Medecine medecine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: 150,
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
      child: Column(children: <Widget>[
        Image.network(
          medecine.img,
          height: 70,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          medecine.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              medecine.dci,
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 10,
              ),
            ),
            Text(
              medecine.category,
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 10,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
