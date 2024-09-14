import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/screens/annuary/annuary_screen_page.dart';
import 'package:nuncare_mobile_firebase/screens/home/home_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/message/message_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/profile/profile_page_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MyDefaultNavbar extends StatelessWidget {
  const MyDefaultNavbar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).colorScheme.primary,
      unselectedFontSize: 12,
      selectedFontSize: 12,
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color.fromARGB(170, 0, 0, 0),
      iconSize: 32,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: "Accueil",
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.people),
          label: "Annuaire",
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.chat_bubble),
          // icon: Image.asset(
          //   'assets/icons/discuter.png',
          //   width: 35,
          // ),
          label: "Messagerie",
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          // icon: Image.asset(
          //   'assets/icons/utilisateur.png',
          //   width: 35,
          // ),
          label: "Profil",
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        // BottomNavigationBarItem(
        //   icon: const Icon(Icons.door_back_door),
        //   // icon: Image.asset(
        //   //   'assets/icons/utilisateur.png',
        //   //   width: 35,
        //   // ),
        //   label: "Test",
        //   backgroundColor: Theme.of(context).colorScheme.primary,
        // ),
      ],
      currentIndex: currentIndex,
      onTap: onItemTapped,
    );
  }
}
