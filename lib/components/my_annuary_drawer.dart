import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/screens/other/medecines_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/other/pharmacies_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';

class MyAnnuaryDrawer extends StatelessWidget {
  MyAnnuaryDrawer({super.key});

  final AuthService _auth = AuthService();

  void _logout() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Drawer(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: ListView(
            children: [
              DrawerHeader(
                child: Image.asset(
                  'assets/images/title_nuncare.png',
                  scale: 2,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const MedecinesPageScreen(),
                    ),
                  );
                },
                leading: Image.asset(
                  'assets/icons/medi.png',
                  width: 30,
                ),
                title: const Text(
                  "Tous les médicaments assurés",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const PharmaciesPageScreen(),
                    ),
                  );
                },
                leading: Image.asset(
                  'assets/icons/pharmacie.png',
                  width: 30,
                ),
                title: const Text(
                  "Consultez les pharmacies",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
