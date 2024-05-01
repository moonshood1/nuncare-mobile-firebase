import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/screens/other/diary_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/other/medecines_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final AuthService _auth = AuthService();

  void _logout() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
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
              leading: const Icon(Icons.medical_services_outlined),
              title: const Text(
                "Tous les médicaments assurés",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.local_hospital),
              title: const Text(
                "Consultez les pharmacies",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const DiaryScreenPage(),
                  ),
                );
              },
              leading: const Icon(Icons.folder),
              title: const Text(
                'Les articles publiés',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            ListTile(
              onTap: _logout,
              leading: const Icon(Icons.logout),
              title: const Text(
                'Déconnexion',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    );
  }
}
