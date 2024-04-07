import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/screens/auth/auth_gate.dart';
import 'package:nuncare_mobile_firebase/screens/auth/password_reset_screen.dart';
import 'package:nuncare_mobile_firebase/screens/auth/register_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/validators/email_validator.dart';
import 'package:nuncare_mobile_firebase/validators/password_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  var _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  void _login(BuildContext context) async {
    try {
      // setState(() {
      //   _isLoading = true;
      // });

      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        },
      );

      await _auth.signIn(
        _emailController.text.trim(),
        _pwController.text.trim(),
      );

      Navigator.of(context).pop();

      // setState(() {
      //   _isLoading = false;
      // });

      if (!context.mounted) {
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthGate()),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            e.toString(),
          ),
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
                Image.asset(
                  "assets/images/logo_nuncare.png",
                  width: 80,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Connectez vous à votre compte",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                  controller: _emailController,
                  obscureText: false,
                  labelText: "Email",
                  icon: Icons.email,
                  validator: (value) => validateEmail(value),
                  isHidden: false,
                  autoCorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: _pwController,
                  obscureText: true,
                  icon: Icons.lock,
                  labelText: "Mot de passe",
                  validator: (value) => validatePassword(value),
                  isHidden: true,
                  autoCorrect: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                ),
                const SizedBox(
                  height: 15,
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (ctx) => const PasswordResetScreen(),
                //         ),
                //       );
                //     },
                //     child: Text(
                //       'Mot de passe oublié ?',
                //       style: TextStyle(
                //         fontSize: 14,
                //         fontWeight: FontWeight.w300,
                //         color: Theme.of(context).colorScheme.primary,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                _isLoading
                    ? const MyLoadingCirle()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _login(context),
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
                            "Connexion",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 60,
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
