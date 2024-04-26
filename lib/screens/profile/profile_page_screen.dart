import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_text_box.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';
import 'package:nuncare_mobile_firebase/validators/name_validator.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final AuthService _auth = AuthService();
  final UserService _userService = UserService();
  final TextEditingController _newValueController = TextEditingController();

  Future<void> editField(String field, String label) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Modification $label :",
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        content: MyTextField(
          controller: _newValueController,
          obscureText: false,
          labelText: 'Nom',
          validator: (value) => validateName(value, 'Le nom'),
          isHidden: false,
          autoCorrect: false,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.none,
          icon: Icons.person,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Annuler',
              style: TextStyle(color: Colors.red.shade500),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(_newValueController.text);
            },
            child: const Text('Sauvegarder'),
          )
        ],
      ),
    );

    if (_newValueController.text.trim().isNotEmpty) {
      await _userService.updateUserInformations(
        field,
        _newValueController.text.trim(),
        currentUser.uid,
      );

      _newValueController.clear();
    }
  }

  @override
  void dispose() {
    _newValueController.dispose();
    super.dispose();
  }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: StreamBuilder<DocumentSnapshot>(
          stream: _auth.getUserInformations(currentUser.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(
                    Icons.person,
                    size: 80,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${currentUser.email}",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text("Mes informations"),
                  MyTextBox(
                    text: "${userData['lastName']}",
                    sectionName: 'Nom de famille',
                    onPressed: () => editField('lastName', 'du nom'),
                  ),
                  MyTextBox(
                    text: "${userData['firstName']}",
                    sectionName: 'Prénoms',
                    onPressed: () => editField('firstName', 'du prénom'),
                  ),
                  MyTextBox(
                    text: 'Aucune',
                    sectionName: 'Bio',
                    onPressed: () => editField('bio', 'de la bio'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text('Mes articles'),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const MyLoadingCirle();
            }
          },
        ),
      ),
    );
  }
}
