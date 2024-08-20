import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/cloudinary_service.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';

class ImageEditPageScreen extends StatefulWidget {
  const ImageEditPageScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<ImageEditPageScreen> createState() => _ImageEditPageScreenState();
}

class _ImageEditPageScreenState extends State<ImageEditPageScreen> {
  final UserService _userService = UserService();
  final CloudinarySevice _cloudinarySevice = CloudinarySevice();

  File? _selectedImage;
  var _isGallery = false;
  var _isLoading = false;

  void _takePicture() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _isGallery = false;
      _selectedImage = File(pickedImage.path);
    });
  }

  void _pickPicture() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _isGallery = true;
      _selectedImage = File(pickedImage.path);
    });
  }

  void _uploadPicture(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final imgUrl = await _cloudinarySevice.uploadImageOnCloudinary(
        _selectedImage!,
      );

      BasicResponse responseApi =
          await _userService.updateUserInformations('img', imgUrl);

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

  void _reinitValues() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget imageUploadContent = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: _takePicture,
          icon: Icon(
            Icons.camera,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: Text(
            "Prenez une photo",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton.icon(
          onPressed: _pickPicture,
          icon: Icon(
            Icons.image,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: Text(
            "Choisissez une image",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    );

    if (_selectedImage != null) {
      imageUploadContent = GestureDetector(
        onTap: _isGallery ? _pickPicture : _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modification de la photo de profil",
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.doctor.img != ''
                    ? "Changez votre image de profil en choisissant une image dans votre gallerie ou en prenant une photo"
                    : "Ajoutez une image de profil en choisissant une image dans votre gallerie ou en prenant une photo ",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 250,
                width: double.infinity,
                alignment: Alignment.center,
                child: imageUploadContent,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed:
                        _isLoading ? null : () => _uploadPicture(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      "Enregistrer",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  ElevatedButton(
                    onPressed: _reinitValues,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red.shade300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      "Réinitialiser",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
