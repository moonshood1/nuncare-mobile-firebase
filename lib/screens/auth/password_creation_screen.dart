import 'package:flutter/material.dart';

class PasswordCreationScreen extends StatefulWidget {
  const PasswordCreationScreen({super.key});

  @override
  State<PasswordCreationScreen> createState() => _PasswordCreationScreenState();
}

class _PasswordCreationScreenState extends State<PasswordCreationScreen> {
  final _form = GlobalKey<FormState>();
  var _obscureText = true;
  String _password = '';
  // var _isLoading = false;

  void _submit() {
    final isValid = _form.currentState!.validate();

    if (isValid) {
      _form.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => const PasswordCreationScreen(),
        ),
      );
      print(_password);
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
        padding: EdgeInsets.symmetric(
          vertical: deviceWidth(context) * 0.09,
          horizontal: deviceWidth(context) * 0.05,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
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
                  "Changement de mot de passe ",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Saisissez votre nouveau mot de passe de connexion",
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  obscureText: _obscureText,
                  validator: (value) {
                    if ((value ?? '').length < 6) {
                      return 'Le mot de passe doit contenir au moins 6 caractères';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    labelText: "Nouveau mot de passe",
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red.shade300,
                      ),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    errorStyle: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: _obscureText,
                  validator: (value) {
                    if ((value ?? '').length < 6) {
                      return 'Le mot de passe doit contenir au moins 6 caractères';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    labelText: "Confirmez le mot de passe",
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red.shade300,
                      ),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    errorStyle: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
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
                      "Modifier le mot de passe",
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
      ),
    );
  }
}
