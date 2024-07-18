import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_selectfield.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/constants/default_values.dart';
import 'package:nuncare_mobile_firebase/validators/number_validator.dart';

class CustomAnnuaryScreenPage extends StatefulWidget {
  const CustomAnnuaryScreenPage({super.key});

  @override
  State<CustomAnnuaryScreenPage> createState() =>
      _CustomAnnuaryScreenPageState();
}

class _CustomAnnuaryScreenPageState extends State<CustomAnnuaryScreenPage> {
  String? _selectedSpeciality;
  String? _selectedRegion;
  var _isLoading = false;

  final TextEditingController _promotionController = TextEditingController();

  @override
  void dispose() {
    _promotionController.dispose();
    super.dispose();
  }

  void _submitData() async {
    setState(() {
      _isLoading = true;
    });

    Navigator.of(context).pop({
      'region': _selectedRegion,
      'speciality': _selectedSpeciality ?? '',
      'promotion': _promotionController.text
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: <Widget>[
            const Text(
              "Sélectionnez vos critères de recherche",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MySelectField(
              label: 'Choisissez une région',
              items: defaultRegions.keys.toList(),
              icon: Icons.map,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRegion = newValue;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            MySelectField(
              label: 'Choisissez une spécialité',
              items: defaultSpecialities,
              icon: Icons.medical_services,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSpeciality = newValue;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _promotionController,
              obscureText: false,
              labelText: "Choisissez la promotion",
              validator: (value) => validateNumber(value, "La promotion"),
              isHidden: false,
              autoCorrect: false,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.none,
              icon: Icons.school,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: _isLoading
                  ? const MyLoadingCirle()
                  : ElevatedButton(
                      onPressed: _submitData,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Effectuer la recherche",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
