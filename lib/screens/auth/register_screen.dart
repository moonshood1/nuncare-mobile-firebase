import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/screens/auth/login_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/validators/email_validator.dart';
import 'package:nuncare_mobile_firebase/validators/name_validator.dart';
import 'package:nuncare_mobile_firebase/validators/password_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var _isLoading = false;
  final _auth = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _confirmPwController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();

    super.dispose();
  }

  void _submit(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      BasicResponse response = await _auth.signUp(
        _emailController.text.trim(),
        _pwController.text.trim(),
        _firstnameController.text.trim(),
        _lastnameController.text.trim(),
      );

      if (!context.mounted) {
        return;
      }

      if (response.success) {
        setState(() {
          _isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => const LoginScreen(),
          ),
        );
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
          backgroundColor: Colors.red.shade400,
          content: Text(e.toString()),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset(
                  "assets/images/logo_nuncare.png",
                  width: 60,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Créez votre compte",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 25,
                    fontFamily: "Roboto",
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    MyTextField(
                      controller: _firstnameController,
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
                      controller: _lastnameController,
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
                    MyTextField(
                      controller: _emailController,
                      obscureText: false,
                      isHidden: false,
                      icon: Icons.email,
                      labelText: 'Email',
                      validator: (value) => validateEmail(value),
                      textCapitalization: TextCapitalization.none,
                      autoCorrect: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      isHidden: true,
                      controller: _pwController,
                      obscureText: true,
                      icon: Icons.lock,
                      labelText: 'Mot de passe',
                      validator: (value) => validatePassword(value),
                      autoCorrect: false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      controller: _confirmPwController,
                      obscureText: true,
                      isHidden: true,
                      icon: Icons.lock,
                      labelText: 'Confirmez votre mot de passe',
                      autoCorrect: false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) => validateRepeatedPassword(
                        value,
                        _pwController.text,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? const MyLoadingCirle()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _submit(context),
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            foregroundColor: Colors.white,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Inscription",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Vous avez déja une compte ? ",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Connectez-vous",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
