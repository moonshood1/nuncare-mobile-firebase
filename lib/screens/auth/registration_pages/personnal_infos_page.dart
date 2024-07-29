import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/utils/phone_formatter.dart';
import 'package:nuncare_mobile_firebase/validators/name_validator.dart';
import 'package:nuncare_mobile_firebase/validators/number_validator.dart';

class PersonalInfosPage extends StatefulWidget {
  PersonalInfosPage({
    super.key,
    required this.controller,
    required this.firstnameController,
    required this.lastnameController,
    required this.phoneController,
    required this.selectedGender,
    required this.onChangeGender,
  });

  final PageController controller;
  final TextEditingController firstnameController,
      lastnameController,
      phoneController;
  String selectedGender;
  final void Function(String value) onChangeGender;

  @override
  State<PersonalInfosPage> createState() => _PersonalInfosPageState();
}

class _PersonalInfosPageState extends State<PersonalInfosPage>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();

  void _validateAndProceed() {
    print('Etat validation : ${_formKey.currentState?.validate()}');
    if (_formKey.currentState?.validate() ?? false) {
      widget.controller.nextPage(
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text(
                        'Homme',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'H',
                        groupValue: widget.selectedGender,
                        onChanged: (value) {
                          widget.onChangeGender(value!);
                          widget.selectedGender = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text(
                        'Femme',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      leading: Radio<String>(
                        splashRadius: 1,
                        value: 'F',
                        groupValue: widget.selectedGender,
                        onChanged: (value) {
                          widget.onChangeGender(value!);
                          widget.selectedGender = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
              MyTextField(
                controller: widget.firstnameController,
                obscureText: false,
                isHidden: false,
                icon: Icons.person,
                labelText: 'Prénom',
                validator: (value) => validateName(value, 'Le prénom'),
                textCapitalization: TextCapitalization.sentences,
                autoCorrect: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: widget.lastnameController,
                obscureText: false,
                isHidden: false,
                icon: Icons.person,
                labelText: 'Nom',
                validator: (value) => validateName(value, "Le nom"),
                textCapitalization: TextCapitalization.words,
                autoCorrect: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              // MyTextField(
              //   controller: widget.bioController,
              //   obscureText: false,
              //   isHidden: false,
              //   icon: Icons.folder_copy,
              //   labelText: 'Bio',
              //   validator: (value) => validateLongText(value, 'La bio', 10),
              //   textCapitalization: TextCapitalization.none,
              //   autoCorrect: false,
              //   keyboardType: TextInputType.text,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              MyTextField(
                controller: widget.phoneController,
                obscureText: false,
                labelText: 'Numéro de téléphone',
                validator: (value) =>
                    validateNumber(value, 'le numéro de téléphone'),
                isHidden: false,
                autoCorrect: false,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.none,
                icon: Icons.phone,
                inputFormatter: [PhoneNumberFormatter()],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateAndProceed,
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
                    "Suivant",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
