import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/screens/annuary/annuary_screen_page.dart';
import 'package:nuncare_mobile_firebase/screens/home/home_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/message/message_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/profile/profile_page_screen.dart';

class RootPageScreen extends StatefulWidget {
  const RootPageScreen({super.key});

  @override
  State<RootPageScreen> createState() => _RootPageScreenState();
}

class _RootPageScreenState extends State<RootPageScreen> {
  int _selectedIndex = 0;
  var activeScreen = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      activeScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = const HomePageScreen();

    switch (activeScreen) {
      case 1:
        screenWidget = const AnnuaryPageScreen();

        break;
      case 2:
        screenWidget = MessagePageScreen();

        break;
      case 3:
        screenWidget = const ProfilePageScreen();

        break;
    }

    return Scaffold(
      body: screenWidget,
      bottomNavigationBar: BottomNavigationBar(
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
            label: "Messagerie",
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "Profil",
            backgroundColor: Theme.of(context).colorScheme.primary,
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
