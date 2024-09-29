import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_settings_list_tile.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';

class MaskInformationsPageScreen extends StatefulWidget {
  const MaskInformationsPageScreen({
    super.key,
  });

  @override
  State<MaskInformationsPageScreen> createState() =>
      _MaskInformationsPageScreenState();
}

class _MaskInformationsPageScreenState
    extends State<MaskInformationsPageScreen> {
  final UserService _userService = UserService();
  Doctor currentUser = Doctor.defaultDoctor();

  bool hidePhone = false;
  bool hideOrderNumber = false;

  void getInformationsFromStore() async {
    try {
      Doctor response = await _userService.getInformations();

      setState(() {
        currentUser = response;
        hidePhone = currentUser.isPhoneHidden;
        hideOrderNumber = currentUser.isOrderNumberHidden;
      });
    } catch (e) {
      print(e);
    }
  }

  void toggleValues() async {
    await _userService.toggleHiddensValues(
      phone: hidePhone,
      orderNumber: hideOrderNumber,
    );

    getInformationsFromStore();
  }

  @override
  void initState() {
    getInformationsFromStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Masquer les informations',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
      body: Column(
        children: [
          MySettingsListTile(
            title: 'Masquer / Demasquer le numéro de téléphone',
            color: Colors.grey.shade200,
            textColor: Colors.grey.shade600,
            action: CupertinoSwitch(
              value: hidePhone,
              onChanged: (value) {
                setState(() {
                  hidePhone = value;
                });
                toggleValues();
              },
            ),
          ),
          MySettingsListTile(
            title: "Masquer / Demasquer le numéro d'ordre",
            color: Colors.grey.shade200,
            textColor: Colors.grey.shade600,
            action: CupertinoSwitch(
              value: hideOrderNumber,
              onChanged: (value) {
                setState(() {
                  hideOrderNumber = value;
                });
                toggleValues();
              },
            ),
          ),
        ],
      ),
    );
  }
}
