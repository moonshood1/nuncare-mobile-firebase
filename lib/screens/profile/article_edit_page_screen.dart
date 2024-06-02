import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/cloudinary_service.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';
import 'package:nuncare_mobile_firebase/validators/long_text_validator.dart';

class ArticleEditPageScreen extends StatefulWidget {
  const ArticleEditPageScreen({super.key});

  @override
  State<ArticleEditPageScreen> createState() => _ArticleEditPageScreenState();
}

class _ArticleEditPageScreenState extends State<ArticleEditPageScreen> {
  final UserService _userService = UserService();
  final CloudinarySevice _cloudinarySevice = CloudinarySevice();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  File? _selectedImage;
  var _isLoading = false;

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
      _selectedImage = File(pickedImage.path);
    });
  }

  void submitArticle(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final imgUrl = await _cloudinarySevice.uploadImageOnCloudinary(
        _selectedImage!,
      );

      BasicResponse response = await _userService.createArticle(
        _titleController.text,
        _descriptionController.text,
        _contentController.text,
        imgUrl,
      );

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
      Navigator.of(context).pop();
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
    Widget articleImageUpload = TextButton.icon(
      onPressed: _pickPicture,
      icon: Icon(
        Icons.image,
        color: Theme.of(context).colorScheme.primary,
      ),
      label: Text(
        "Choisissez l'image de l'article",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
    if (_selectedImage != null) {
      articleImageUpload = GestureDetector(
        onTap: _pickPicture,
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
          "Création d'un article",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Rédaction de l'article",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Uploadez l'image de votre article et completez les champs avant de soumettre voter article",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 200,
                width: double.infinity,
                alignment: Alignment.center,
                child: articleImageUpload,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: _titleController,
                obscureText: false,
                labelText: "Titre de l'article",
                validator: (value) =>
                    validateLongText(value, "Le titre de l'article", 10),
                isHidden: false,
                autoCorrect: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                icon: Icons.title,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: _descriptionController,
                obscureText: false,
                labelText: "La description de l'article",
                validator: (value) =>
                    validateLongText(value, "La description de l'article", 10),
                isHidden: false,
                autoCorrect: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                icon: Icons.title,
                maxLines: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: _contentController,
                obscureText: false,
                labelText: "Ecrivez votre article",
                validator: (value) =>
                    validateLongText(value, "Le contenu de l'article", 20),
                isHidden: false,
                autoCorrect: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                icon: Icons.content_copy,
                maxLines: 3,
              ),
              const SizedBox(
                height: 30,
              ),
              _isLoading
                  ? const MyLoadingCirle()
                  : ElevatedButton(
                      onPressed: () => submitArticle(context),
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
                        "Soumettre l'article",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
