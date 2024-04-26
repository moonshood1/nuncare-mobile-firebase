import 'package:flutter/material.dart';

class DoctorProfilePageScreen extends StatelessWidget {
  const DoctorProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Colors.white,
      ),
      drawer: const Drawer(),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text('Profil'),
      ),
    );
  }
}
