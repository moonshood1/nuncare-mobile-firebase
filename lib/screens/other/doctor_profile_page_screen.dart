import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_info_box.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/screens/message/chat_page_screen.dart';

class DoctorProfilePageScreen extends StatelessWidget {
  const DoctorProfilePageScreen({super.key, required this.doctor});

  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    doctor.img,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              doctor.email,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text("Informations"),
            MyInfoBox(
              text: doctor.lastName,
              sectionName: 'Nom de famille',
            ),
            MyInfoBox(
              text: doctor.firstName,
              sectionName: 'Prénoms',
            ),
            MyInfoBox(
              text: doctor.orderNumber,
              sectionName: "Numéro de d'ordre",
            ),
            MyInfoBox(
              text: doctor.phone,
              sectionName: 'Numéro de téléphone',
            ),
            MyInfoBox(
              sectionName: 'Bio',
              text: doctor.bio,
            ),
            MyInfoBox(
              sectionName: 'Hopital',
              text: doctor.hospital,
            ),
            MyInfoBox(
              sectionName: 'Spécialité',
              text: doctor.speciality,
            ),
            MyInfoBox(
              sectionName: 'Ville',
              text: doctor.city,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text('Articles'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.send),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ChatPageScreen(
              receiverName: "${doctor.firstName} ${doctor.lastName}",
              receiverId: doctor.id!,
              // receiverEmail: doctor.email,
            ),
          ),
        ),
      ),
    );
  }
}
