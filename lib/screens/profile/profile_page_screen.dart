import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_text_box.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';
import 'package:nuncare_mobile_firebase/validators/name_validator.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  final UserService _userService = UserService();
  final TextEditingController _newValueController = TextEditingController();
  var _isLoading = false;
  Doctor currentUser = Doctor.defaultDoctor();

  Future<void> editField(String field, String label, String labelText) async {
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
          labelText: labelText,
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
        currentUser.id!,
      );

      _newValueController.clear();
    }
  }

  void getInformationsFromStore() async {
    try {
      setState(() {
        _isLoading = true;
      });

      Doctor response = await _userService.getInformations();

      setState(() {
        currentUser = response;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _newValueController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getInformationsFromStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget userContent = ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  currentUser.img,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          currentUser.email,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 40,
        ),
        const Text("Mes informations"),
        MyTextBox(
          text: currentUser.lastName,
          sectionName: 'Nom de famille',
          onPressed: () => editField('lastName', 'du nom', "Nom"),
        ),
        MyTextBox(
          text: currentUser.firstName,
          sectionName: 'Prénom',
          onPressed: () => editField('firstName', 'du prénom', 'Prénom'),
        ),
        MyTextBox(
          text: currentUser.bio,
          sectionName: 'Bio',
          onPressed: () => editField('bio', 'de la bio', "Bio"),
        ),
        MyTextBox(
          text: currentUser.orderNumber,
          sectionName: "Numéro d'ordre",
          onPressed: () => editField('hospital', "de l'hopital", "Hopital"),
        ),
        MyTextBox(
          text: currentUser.hospital,
          sectionName: 'Hopital',
          onPressed: () => editField('hospital', "de l'hopital", "Hopital"),
        ),
        MyTextBox(
          text: currentUser.speciality,
          sectionName: 'Spécialité',
          onPressed: () =>
              editField('speciality', 'de la spécialité', "Spécialité"),
        ),
        MyTextBox(
          text: currentUser.years.toString(),
          sectionName: "Années d'expérience",
          onPressed: () => editField(
              'years', "des années d'expérience", "Année d'experience"),
        ),
        MyTextBox(
          text: currentUser.phone,
          sectionName: 'Téléphone',
          onPressed: () => editField(
              'phone', 'du numéro de téléphone', "Numéro de téléphone"),
        ),
        MyTextBox(
          text: currentUser.city,
          sectionName: 'Ville',
          onPressed: () => editField('city', 'de la ville', "Ville"),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text('Mes articles'),
      ],
    );

    if (_isLoading) {
      userContent = const Center(
        child: MyLoadingCirle(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Colors.white,
      ),
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: userContent,
      ),
    );
  }
}




        // StreamBuilder<DocumentSnapshot>(
        //   stream: _userService.getUserInformations(currentUser.uid),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       final userData = snapshot.data!.data() as Map<String, dynamic>;

        //       return 
              
              

            // } else if (snapshot.hasError) {
            //   return Center(
            //     child: Text(snapshot.error.toString()),
            //   );
            // } else {
            //   return const MyLoadingCirle();
            // }
