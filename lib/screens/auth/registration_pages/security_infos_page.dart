import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/screens/policy/policy_screen_page.dart';
import 'package:nuncare_mobile_firebase/validators/email_validator.dart';
import 'package:nuncare_mobile_firebase/validators/password_validator.dart';

class SecurityPageInfos extends StatefulWidget {
  SecurityPageInfos({
    super.key,
    required this.controller,
    required this.emailController,
    required this.pwController,
    required this.confirmPwController,
    required this.policyTermsCheck,
    required this.dataTermsCheck,
    required this.onChangeTerms,
    required this.onChangePolicy,
    required this.isLoading,
    required this.onSubmit,
  });

  final PageController controller;
  final TextEditingController emailController,
      pwController,
      confirmPwController;
  bool dataTermsCheck, policyTermsCheck, isLoading;
  final ValueChanged<bool?> onChangeTerms, onChangePolicy;
  final void Function() onSubmit;

  @override
  State<SecurityPageInfos> createState() => _SecurityPageInfosState();
}

class _SecurityPageInfosState extends State<SecurityPageInfos> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            MyTextField(
              controller: widget.emailController,
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
              controller: widget.pwController,
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
              controller: widget.confirmPwController,
              obscureText: true,
              isHidden: true,
              icon: Icons.lock,
              labelText: 'Confirmez votre mot de passe',
              autoCorrect: false,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              validator: (value) => validateRepeatedPassword(
                value,
                widget.pwController.text,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                  value: widget.policyTermsCheck,
                  onChanged: (bool? newValue) {
                    widget.policyTermsCheck = newValue ?? false;
                    widget.onChangePolicy(newValue);
                    setState(() {});
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(text: "J'accepte les "),
                        TextSpan(
                          text: "termes et conditions d'utilisation",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => const PolicyScreenPage(),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: widget.dataTermsCheck,
                  onChanged: (bool? newValue) {
                    widget.dataTermsCheck = newValue ?? false;
                    widget.onChangeTerms(newValue);
                    setState(() {});
                  },
                ),
                const Expanded(
                  child: Text(
                    "Je consens à la collecte et à l'utilisation de mes données sensibles.",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
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
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.controller.previousPage(
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          curve: Curves.easeOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Retour",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onSubmit();
                      },
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
                        "S'inscrire",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
