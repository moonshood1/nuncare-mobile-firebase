import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_user_card_row.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';

class DoctorPagescreen extends StatefulWidget {
  const DoctorPagescreen({super.key});

  @override
  State<DoctorPagescreen> createState() => _DoctorPagescreenState();
}

class _DoctorPagescreenState extends State<DoctorPagescreen> {
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Annuaire des medecins",
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth(context) * 0.05,
          vertical: deviceWidth(context) * 0.03,
        ),
        child:
            // MyCategoryRow(),
            StreamBuilder(
          stream: _userService.getUserStream(),
          builder: (ctx, snapshot) {
            // error
            if (snapshot.hasError) {
              return const Text("Erreur au chargement des utilisateurs");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MyLoadingCirle();
            }

            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "Aucun docteurs dans l'annuaire",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              );
            }

            return ListView(
              children: snapshot.data!
                  .map(
                    (userData) => _buildUserListItem(userData, ctx),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return MyUserRow(
        name: "${userData["firstName"]} ${userData["lastName"]}",
        onTap: () {},
        id: userData['uid'],
        img:
            "https://res.cloudinary.com/dhc0siki5/image/upload/v1710070251/nuncare/person_i8vdce.jpg",
      );
    } else {
      return Container();
    }
  }
}
