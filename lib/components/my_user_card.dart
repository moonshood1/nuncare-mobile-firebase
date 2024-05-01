import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/screens/other/doctor_profile_page_screen.dart';

class MyUserCard extends StatelessWidget {
  const MyUserCard({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DoctorProfilePageScreen(
              doctor: doctor,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        doctor.img,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text("${doctor.firstName} ${doctor.lastName}"),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  doctor.speciality,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  doctor.address,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
