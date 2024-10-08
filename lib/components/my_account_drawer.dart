import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/screens/other/settings_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/profile/article_edit_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/profile/profile_edit_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';

class MyAccountDrawer extends StatelessWidget {
  MyAccountDrawer({super.key, required this.doctor});

  final AuthService _auth = AuthService();
  final Doctor doctor;

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
                      builder: (ctx) => const ArticleEditPageScreen(),
                    ),
                  );
                },
                leading: Image.asset(
                  'assets/icons/ecrire.png',
                  width: 30,
                ),
                title: const Text(
                  "Ecrire un article",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => ProfileEditPageScreen(
                        doctor: doctor,
                      ),
                    ),
                  );
                },
                leading: Image.asset(
                  'assets/icons/editer.png',
                  width: 30,
                ),
                title: const Text(
                  "Modifier mon profil",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => SettingsPageScreen(
                        doctor: doctor,
                      ),
                    ),
                  );
                },
                leading: Image.asset(
                  'assets/icons/parametres.png',
                  width: 30,
                ),
                title: const Text(
                  'Paramètres',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              ListTile(
                onTap: _logout,
                leading: Image.asset(
                  'assets/icons/se-deconnecter.png',
                  width: 30,
                ),
                // const Icon(Icons.logout),
                title: const Text(
                  'Déconnexion',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
