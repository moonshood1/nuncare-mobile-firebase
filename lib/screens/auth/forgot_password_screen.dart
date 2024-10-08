import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/screens/auth/login_screen.dart';
import 'package:nuncare_mobile_firebase/screens/auth/register_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/validators/email_validator.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';

class ForgotPwScreen extends StatefulWidget {
  const ForgotPwScreen({super.key});

  @override
  State<ForgotPwScreen> createState() => _ForgotPwScreenState();
}

class _ForgotPwScreenState extends State<ForgotPwScreen> {
  var _isLoading = false;
  final _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final String? emailError = validateEmail(_emailController.text);

      if (emailError != null) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade200,
            content: const Text(
              "L'adresse email n'est pas valide",
            ),
            duration: const Duration(seconds: 4),
          ),
        );

        return;
      }

      if (!context.mounted) {
        return;
      }

      _auth.resetPassword(_emailController.text);

      setState(() {
        _isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => const LoginScreen(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade200,
          content: const Text(
            "Un email vous a été envoyé pour reinitialiser votre mot de passe",
          ),
          duration: const Duration(seconds: 4),
        ),
      );

      return;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade200,
          content: Text(
            e.toString(),
          ),
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
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo_nuncare.png",
                  width: 80,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Réinitialisation de mot de passe",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Renseignez votre adresse email",
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                  controller: _emailController,
                  obscureText: false,
                  icon: Icons.email,
                  labelText: "Email",
                  validator: (value) => validateEmail(value),
                  isHidden: false,
                  autoCorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                ),
                const SizedBox(
                  height: 40,
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
                            "Continuer",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Vous n'avez pas de compte ? ",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Créer un compte",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
