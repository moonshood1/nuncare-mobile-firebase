import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuncare_mobile_firebase/components/my_selectfield.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/cloudinary_service.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';
import 'package:nuncare_mobile_firebase/validators/name_validator.dart';

class KycPageScreen extends StatefulWidget {
  const KycPageScreen({super.key});

  @override
  State<KycPageScreen> createState() => _KycPageScreenState();
}

class _KycPageScreenState extends State<KycPageScreen> {
  final UserService _userService = UserService();
  final ResourceService _resourceService = ResourceService();
  final CloudinarySevice _cloudinarySevice = CloudinarySevice();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _documentNumberController =
      TextEditingController();

  List<String> _documentTypes = [];
  String? _selectedDocument;
  String returnVerso = "";
  String returnRecto = "";
  String returnSelfie = "";
  File? _imageRecto;
  File? _imageVerso;
  File? _imageSelfie;
  var _isLoading = false;

  void getDocumentTypesFromStore() async {
    try {
      List<String> response = await _resourceService.getKycDocuments();

      setState(() {
        _documentTypes = response;
      });
    } catch (error) {
      print(error);
    }
  }

  void _takePicture(String imageType) async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    if (imageType == "RECTO") {
      _imageRecto = File(pickedImage.path);
    }

    if (imageType == "VERSO") {
      _imageVerso = File(pickedImage.path);
    }

    if (imageType == "SELFIE") {
      _imageSelfie = File(pickedImage.path);
    }

    setState(() {});
  }

  void _uploadPicture(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<File> pictures = [_imageRecto!, _imageVerso!, _imageSelfie!];
      List<String> imageTypes = ["recto", "verso", "selfie"];
      Map<String, String> imageUrls = {};

      for (int i = 0; i < pictures.length; i++) {
        final imgUrl = await _cloudinarySevice.uploadImageOnCloudinary(
          pictures[i],
        );
      }

      Map<String, String> userKycData = {
        "firstName": _firstNameController.text.trim(),
        "lastName": _lastNameController.text.trim(),
        "documentNumber": _documentNumberController.text.trim(),
        "documentType": _selectedDocument!,
        "recto": returnRecto,
        "verso": returnVerso,
        "picture": returnSelfie,
      };

      BasicResponse responseApi = await _userService.submitKyc(userKycData);

      if (!context.mounted) {
        return;
      }

      if (responseApi.success) {
        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pop(true);
        Navigator.of(context).pop();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade200,
          content: Text(responseApi.message),
          duration: const Duration(seconds: 4),
        ),
      );
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
          "Vérification du profil",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Saissisez vos informations puis validez votre vérification",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              controller: _lastNameController,
              obscureText: false,
              isHidden: false,
              icon: Icons.person,
              labelText: 'Nom de famille',
              validator: (value) => validateName(value, 'Le nom de famille'),
              textCapitalization: TextCapitalization.sentences,
              autoCorrect: false,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _firstNameController,
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
            MySelectField(
              label: 'Type de document',
              items: _documentTypes,
              icon: Icons.document_scanner,
              onChanged: (String? newValue) {
                _selectedDocument = newValue;

                setState(() {});
              },
              selectedValue: _selectedDocument,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _documentNumberController,
              obscureText: false,
              isHidden: false,
              icon: Icons.credit_card,
              labelText: 'Numéro de document',
              validator: (value) =>
                  validateName(value, 'Le numéro de document'),
              textCapitalization: TextCapitalization.none,
              autoCorrect: false,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton.icon(
                      onPressed: () => _takePicture('RECTO'),
                      icon: Icon(
                        Icons.camera,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: Text(
                        "Document Recto",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton.icon(
                      onPressed: () => _takePicture('VERSO'),
                      icon: Icon(
                        Icons.camera,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: Text(
                        "Document Verso",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton.icon(
                      onPressed: () => _takePicture('SELFIE'),
                      icon: Icon(
                        Icons.camera,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: Text(
                        "Photo Selfie",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => _uploadPicture(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Soumettre les informations",
                  style: TextStyle(
                    fontSize: 15,
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
}
