import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_selectfield.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/constants/default_values.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';
import 'package:nuncare_mobile_firebase/validators/long_text_validator.dart';
import 'package:nuncare_mobile_firebase/validators/name_validator.dart';
import 'package:nuncare_mobile_firebase/validators/number_validator.dart';
import 'package:nuncare_mobile_firebase/validators/phone_validator.dart';

class ProfileEditPageScreen extends StatefulWidget {
  const ProfileEditPageScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<ProfileEditPageScreen> createState() => _ProfileEditPageScreenState();
}

class _ProfileEditPageScreenState extends State<ProfileEditPageScreen> {
  final UserService _userService = UserService();
  final ResourceService _resourceService = ResourceService();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _orderNumberController = TextEditingController();
  final TextEditingController _promotionController = TextEditingController();
  String? _selectedSpeciality;
  String? _selectedUniversity;
  String? _selectedRegion;
  String? _selectedCity;
  String? _selectedDistrict;

  bool _isDistrictSelected = false;
  bool _isRegionSelected = false;

  List<String> _districts = [];
  List<String> _regions = [];
  List<String> _cities = [];
  List<String> _specialities = [];

  var _isLoading = false;

  void getSpecialities() async {
    try {
      List<String> response = await _resourceService.getSpecialities();

      setState(() {
        _specialities = response;
      });
    } catch (error) {
      print(error);
    }
  }

  void getRegions() async {
    try {
      List<String> response = await _resourceService.getRegions();

      setState(() {
        _regions = response;
      });
    } catch (error) {
      print(error);
    }
  }

  void getRegionsForDistrict(String district) async {
    try {
      List<String> response =
          await _resourceService.getRegionsForSelectedDistrict(district);

      setState(() {
        _isDistrictSelected = true;
        _regions = response;
      });
    } catch (error) {
      print(error);
    }
  }

  void getCitiesForRegion(String region) async {
    try {
      List<String> response =
          await _resourceService.getCitiesForSelectedRegion(region);

      print('villes obtenues : $response');

      setState(() {
        _isRegionSelected = true;
        _cities = response;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _hospitalController.dispose();
    _yearsController.dispose();
    _phoneController.dispose();
    _orderNumberController.dispose();
    _promotionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _firstNameController.text = widget.doctor.firstName;
    _lastNameController.text = widget.doctor.lastName;
    _bioController.text = widget.doctor.bio;
    _phoneController.text = widget.doctor.phone;
    _selectedRegion = widget.doctor.region;
    // _selectedCity = widget.doctor.city;
    // _selectedDistrict = widget.doctor.district;
    _selectedSpeciality = widget.doctor.speciality;
    _hospitalController.text = widget.doctor.hospital;
    _orderNumberController.text = widget.doctor.orderNumber;
    _yearsController.text = widget.doctor.years.toString();
    _promotionController.text = widget.doctor.promotion;
    _selectedUniversity = widget.doctor.university;

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSpecialities();
      getRegions();
    });
  }

  void editProfile(BuildContext context, String field, dynamic value) async {
    try {
      setState(() {
        _isLoading = true;
      });

      BasicResponse response =
          await _userService.updateUserInformations(field, value);

      if (!context.mounted) {
        return;
      }

      if (response.success) {
        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pop(true);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green.shade200,
            content: Text(response.message),
            duration: const Duration(seconds: 4),
          ),
        );
      }

      return;
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade400,
          content: Text(e.toString()),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  void editProfileBulk(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      Map<String, String> userData = {
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'hospital': _hospitalController.text.trim(),
        'bio': _bioController.text.trim(),
        'university': _selectedUniversity?.trim() ?? '',
        'orderNumber': _orderNumberController.text.trim(),
        'promotion': _promotionController.text.trim(),
        'years': _yearsController.text.trim(),
        'district': _selectedDistrict?.trim() ?? '',
        'region': _selectedRegion?.trim() ?? '',
        'city': _selectedCity?.trim() ?? '',
        'speciality': _selectedSpeciality?.trim() ?? '',
      };
      BasicResponse response =
          await _userService.updateBulkInformations(userData);

      if (!context.mounted) {
        return;
      }

      if (response.success) {
        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pop(true);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade200,
          content: Text(response.message),
          duration: const Duration(seconds: 4),
        ),
      );

      return;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade500,
          content: Text(e.toString()),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modification des données",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: ListView(
          children: [
            const Text(
              'Modification des informations personnelles',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Pour la modification des champs , changez l'information souhaitée et enregistrez ",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextField(
              controller: _firstNameController,
              obscureText: false,
              labelText: "Prénom",
              validator: (value) => validateName(value, 'Le prénom'),
              isHidden: false,
              autoCorrect: false,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              icon: Icons.person,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _lastNameController,
              obscureText: false,
              labelText: "Nom",
              validator: (value) => validateName(value, 'Le nom'),
              isHidden: false,
              autoCorrect: false,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              icon: Icons.person,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _bioController,
              obscureText: false,
              labelText: "Bio",
              validator: (value) => validateLongText(value, 'La bio', 10),
              isHidden: false,
              autoCorrect: false,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              icon: Icons.folder_copy,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _phoneController,
              obscureText: false,
              labelText: "Le numéro de téléphone",
              validator: (value) =>
                  validatePhone(value, "Le numéro de téléphone"),
              isHidden: false,
              autoCorrect: false,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              icon: Icons.medical_services,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Modification des informations professionnelles',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "La procédure de modification est là meme que celle des informations personnelles ",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MySelectField(
              label: 'Votre spécialité',
              items: _specialities,
              icon: Icons.medical_services,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSpeciality = newValue;
                });
              },
              selectedValue: _selectedSpeciality,
            ),
            const SizedBox(
              height: 20,
            ),
            MySelectField(
              label: 'Votre université',
              items: defaultUniversities,
              icon: Icons.school,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUniversity = newValue;
                });
              },
              selectedValue: _selectedUniversity,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _hospitalController,
              obscureText: false,
              labelText: "Votre hopital d'exercice",
              validator: (value) => validateName(value, "L'hopital"),
              isHidden: false,
              autoCorrect: false,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              icon: Icons.medical_information,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _orderNumberController,
              obscureText: false,
              labelText: "Votre numéro d'ordre",
              validator: (value) => validateNumber(value, "Le numéro d'ordre"),
              isHidden: false,
              autoCorrect: false,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.none,
              icon: Icons.medical_information,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _promotionController,
              obscureText: false,
              labelText: "Votre numéro promotion",
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
            MyTextField(
              controller: _yearsController,
              obscureText: false,
              labelText: "Année d'expérience",
              validator: (value) => validateNumber(
                value,
                "Le nombre d'année d'expérience",
              ),
              isHidden: false,
              autoCorrect: false,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.none,
              icon: Icons.calendar_month,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Modification des informations de localisation',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Ici , choisissez votre District , votre région et votre ville d'exercice",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // MySelectField(
            //   label: 'Votre District',
            //   items: _districts,
            //   icon: Icons.map,
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       _selectedDistrict = newValue;
            //       getRegionsForDistrict(newValue!);
            //     });
            //   },
            //   selectedValue: _selectedDistrict,
            // ),
            const SizedBox(
              height: 20,
            ),
            MySelectField(
              label: 'Votre région',
              items: _regions,
              icon: Icons.map,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRegion = newValue;
                  getCitiesForRegion(newValue!);
                });
              },
              selectedValue: _selectedRegion,
            ),
            const SizedBox(
              height: 20,
            ),
            MySelectField(
              label: 'Votre Ville',
              items: _cities,
              icon: Icons.map,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCity = newValue;
                });
              },
              selectedValue: _selectedCity,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => editProfileBulk(context),
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Enregistrer les modifications",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditionField(
      BuildContext context, Widget textfield, String field, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: textfield),
          IconButton(
            onPressed: () {
              editProfile(context, field, value);
            },
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
