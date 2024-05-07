import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_drawer.dart';
import 'package:nuncare_mobile_firebase/components/my_info_box.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/constants/default_values.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/screens/profile/image_edit_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/profile/profile_edit_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  final UserService _userService = UserService();
  var _isLoading = false;
  Doctor currentUser = Doctor.defaultDoctor();

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

  void _goToEditionPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ProfileEditPageScreen(
          doctor: currentUser,
        ),
      ),
    );
    if (result != null && result == true) {
      getInformationsFromStore();
    }
  }

  void _showImagesEditionModal(BuildContext context) async {
    await showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder: (ctx) => _buildPhotoModal(context),
    );
  }

  void _openImageEditionScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ImageEditPageScreen(doctor: currentUser),
      ),
    );

    if (result != null && result == true) {
      getInformationsFromStore();
    }
  }

  void _deleteImage(BuildContext context) async {
    try {
      final result = await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          scrollable: false,
          title: const Text(
            'Confirmation de suppression',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.white,
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Etes-vous sur de vouloir supprimer votre photo de profil ?",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Supprimer"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Annuler",
                style: TextStyle(
                  color: Colors.red.shade500,
                ),
              ),
            )
          ],
        ),
      );

      if (result != null && result == true) {
        BasicResponse response =
            await _userService.updateUserInformations('img', defaultEmptyImg);

        if (!context.mounted) {
          return;
        }

        if (response.success) {
          Navigator.pop(context);

          getInformationsFromStore();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green.shade200,
              content: Text(response.message),
              duration: const Duration(seconds: 4),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red.shade200,
              content: Text(response.message),
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    } catch (e) {
      print(e);
    }
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
          onTap: () {
            _showImagesEditionModal(context);
          },
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
        Row(
          children: [
            const Expanded(
              child: Text("Mes informations"),
            ),
            TextButton.icon(
              onPressed: _goToEditionPage,
              icon: const Icon(Icons.edit),
              label: const Text(
                "Modifier le profil",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
        MyInfoBox(
          text: currentUser.lastName,
          sectionName: 'Nom de famille',
        ),
        MyInfoBox(
          text: currentUser.firstName,
          sectionName: 'Prénom',
        ),
        MyInfoBox(
          text: currentUser.bio,
          sectionName: 'Bio',
        ),
        MyInfoBox(
          text: currentUser.orderNumber,
          sectionName: "Numéro d'ordre",
        ),
        MyInfoBox(
          text: currentUser.hospital,
          sectionName: 'Hopital',
        ),
        MyInfoBox(
          text: currentUser.speciality,
          sectionName: 'Spécialité',
        ),
        MyInfoBox(
          text: currentUser.years.toString(),
          sectionName: "Années d'expérience",
        ),
        MyInfoBox(
          text: currentUser.phone,
          sectionName: 'Téléphone',
        ),
        MyInfoBox(
          text: currentUser.city,
          sectionName: 'Ville',
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
      drawer: MyDrawer(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(
      //     Icons.add,
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: userContent,
      ),
    );
  }

  Widget _buildPhotoModal(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(
              Icons.photo,
            ),
            title: Text(
              currentUser.img != ""
                  ? "Modifier l'image de profil"
                  : "Ajouter une image de profil",
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            onTap: _openImageEditionScreen,
          ),
          ListTile(
            leading: Icon(
              Icons.delete,
              color: Colors.red.shade300,
            ),
            title: const Text(
              "Supprimer l'image de profil",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            onTap: () => _deleteImage(context),
          ),
        ],
      ),
    );
  }
}
