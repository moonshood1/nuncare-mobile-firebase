import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/screens/other/blocked_users_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';

class MyChatDrawer extends StatelessWidget {
  MyChatDrawer({super.key});

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
                      builder: (ctx) => BlockedUsersPageScreen(),
                    ),
                  );
                },
                leading: Image.asset(
                  'assets/icons/article.png',
                  width: 30,
                ),
                title: const Text(
                  'Utilisateurs bloqués',
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
