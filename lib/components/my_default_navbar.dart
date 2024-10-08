import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
      elevation: 10,
      unselectedFontSize: 12,
      selectedFontSize: 12,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: const Color.fromARGB(170, 0, 0, 0),
      iconSize: 32,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          // icon: const Icon(Icons.home),
          icon: Image.asset(
            "assets/icons/page-daccueil.png",
            width: 35,
          ),
          activeIcon: Image.asset(
            "assets/icons/page-daccueil.png",
            width: 35,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: "Accueil",
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/annuaire.png",
            width: 35,
          ),
          activeIcon: Image.asset(
            "assets/icons/annuaire.png",
            width: 35,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: "Annuaire",
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/discuter.png',
            width: 35,
          ),
          activeIcon: Image.asset(
            'assets/icons/discuter.png',
            width: 35,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: "Messagerie",
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/utilisateur-de-profil.png',
            width: 35,
          ),
          activeIcon: Image.asset(
            'assets/icons/utilisateur-de-profil.png',
            width: 35,
            color: Theme.of(context).colorScheme.primary,
          ),
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
