import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_settings_list_tile.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/screens/other/blocked_users_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/other/mask_informations_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/profile/kyc_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPageScreen extends StatelessWidget {
  const SettingsPageScreen({
    super.key,
    required this.doctor,
  });
  final Doctor doctor;

  void deleteUserAccount(BuildContext context) async {
    bool confirm = await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Suppression de compte'),
            content: const Text(
              'Vous etes sur de vouloir supprimer votre compte ? Cette action va supprimer votre compte de manière permanente',
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Message signalé"),
                    ),
                  );
                },
                child: const Text('Confirmer'),
              ),
            ],
          ),
        ) ??
        false;

    if (confirm) {
      try {
        Navigator.pop(context);
        await AuthService().deleteAccount();
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paramètres',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            // MySettingsListTile(
            //   title: 'Mode sombre',
            //   color: Colors.grey.shade200,
            //   textColor: Colors.grey.shade600,
            //   action: CupertinoSwitch(
            //     value: Provider.of<ThemeProvider>(context, listen: false)
            //         .isDarkMode,
            //     onChanged: (value) =>
            //         Provider.of<ThemeProvider>(context, listen: false)
            //             .toggleTheme(),
            //   ),
            // ),
            MySettingsListTile(
              title: 'Utilisateurs bloqués',
              color: Colors.grey.shade200,
              textColor: Colors.grey.shade600,
              action: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BlockedUsersPageScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            MySettingsListTile(
              title: 'Vérifier mon profil',
              color: doctor.kycStatus == 'NOT_STARTED'
                  ? Colors.red.shade300
                  : doctor.kycStatus == 'PENDING'
                      ? Colors.orange.shade300
                      : Colors.green.shade300,
              textColor: Colors.white,
              action: IconButton(
                onPressed: () {
                  if (doctor.kycStatus == 'NOT_STARTED') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const KycPageScreen(),
                      ),
                    );
                  }
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
            MySettingsListTile(
              title: 'Masquer mes informations',
              color: Colors.grey.shade200,
              textColor: Colors.grey.shade600,
              action: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const MaskInformationsPageScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            // MySettingsListTile(
            //   title: 'Fermer le compte',
            //   color: Colors.red.shade400,
            //   textColor: Colors.white,
            //   action: IconButton(
            //     onPressed: () {
            //       deleteUserAccount(context);
            //     },
            //     icon: const Icon(
            //       Icons.close,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
