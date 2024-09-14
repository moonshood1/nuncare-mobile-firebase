import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_default_navbar.dart';
import 'package:nuncare_mobile_firebase/screens/annuary/annuary_screen_page.dart';
import 'package:nuncare_mobile_firebase/screens/home/home_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/message/message_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/profile/profile_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/test/test_screen_page.dart';

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
        screenWidget = const MessagePageScreen();
        break;
      case 3:
        screenWidget = const ProfilePageScreen();
        break;
      // case 4:
      //   screenWidget = const TestPageScreen();
      //   break;
    }

    return Scaffold(
      body: screenWidget,
      bottomNavigationBar: MyDefaultNavbar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
