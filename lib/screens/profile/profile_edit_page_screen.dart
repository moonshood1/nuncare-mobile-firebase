import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_selectfield.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/constants/default_values.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _orderNumberController = TextEditingController();
  final TextEditingController _promotionController = TextEditingController();
  // String? _selectedSpeciality;
  // String? _selectedRegion;

  var _isLoading = false;

  final UserService _userService = UserService();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _hospitalController.dispose();
    _specialityController.dispose();
    _yearsController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _orderNumberController.dispose();
    _promotionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _firstNameController.text = widget.doctor.firstName;
    _lastNameController.text = widget.doctor.lastName;
    _bioController.text = widget.doctor.bio;
    _hospitalController.text = widget.doctor.hospital;
    _specialityController.text = widget.doctor.speciality;
    _yearsController.text = widget.doctor.years.toString();
    _phoneController.text = widget.doctor.phone;
    _cityController.text = widget.doctor.city;
    _orderNumberController.text = widget.doctor.orderNumber;
    _promotionController.text = widget.doctor.promotion;
    super.initState();
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
              "Pour la modification des champs , changez l'information souhaitée et appuyez sur l'icone de changement ",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
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
                  ),
                  IconButton(
                    onPressed: () {
                      editProfile(
                        context,
                        'firstName',
                        _firstNameController.text.trim(),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
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
                  ),
                  IconButton(
                    onPressed: () {
                      editProfile(
                        context,
                        'lastName',
                        _lastNameController.text.trim(),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: _bioController,
                      obscureText: false,
                      labelText: "Bio",
                      validator: (value) =>
                          validateLongText(value, 'La bio', 10),
                      isHidden: false,
                      autoCorrect: false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      icon: Icons.folder_copy,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      editProfile(
                        context,
                        'bio',
                        _bioController.text.trim(),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
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
                  ),
                  IconButton(
                    onPressed: () {
                      editProfile(
                        context,
                        'phone',
                        _phoneController.text.trim(),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: _specialityController,
                      obscureText: false,
                      labelText: "Votre spécialité",
                      validator: (value) =>
                          validateName(value, "La spécialité"),
                      isHidden: false,
                      autoCorrect: false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      icon: Icons.medical_services,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      editProfile(context, 'speciality',
                          _specialityController.text.trim());
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
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
                  ),
                  IconButton(
                    onPressed: () {
                      editProfile(
                        context,
                        'hospital',
                        _hospitalController.text.trim(),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: _orderNumberController,
                      obscureText: false,
                      labelText: "Votre numéro d'ordre",
                      validator: (value) =>
                          validateNumber(value, "Le numéro d'ordre"),
                      isHidden: false,
                      autoCorrect: false,
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      icon: Icons.medical_information,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      editProfile(
                        context,
                        'orderNumber',
                        _orderNumberController.text.trim(),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: _promotionController,
                      obscureText: false,
                      labelText: "Votre numéro promotion",
                      validator: (value) =>
                          validateNumber(value, "La promotion"),
                      isHidden: false,
                      autoCorrect: false,
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      icon: Icons.school,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      editProfile(
                        context,
                        'promotion',
                        _promotionController.text.trim(),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
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
                  ),
                  IconButton(
                    onPressed: () {
                      editProfile(
                        context,
                        'years',
                        _yearsController.text.trim(),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            // const SizedBox(
            //   height: 30,
            // ),
            // const Text(
            //   'Modification des informations de localisation',
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Text(
            //   "Ici , pointez sur la map votre position et vos données seront actualisées",
            //   style: TextStyle(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w300,
            //   ),
            // ),
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
