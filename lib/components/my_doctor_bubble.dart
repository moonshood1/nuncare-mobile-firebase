import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/screens/other/doctor_profile_page_screen.dart';

class MyDoctorBubble extends StatelessWidget {
  const MyDoctorBubble({super.key, required this.doctor});

  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DoctorProfilePageScreen(
              doctor: doctor,
            ),
          ),
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(doctor.img),
              radius: 25,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${doctor.firstName} ${doctor.lastName}",
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
