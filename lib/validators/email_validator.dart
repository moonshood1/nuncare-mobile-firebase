String? validateEmail(String? value) {
  const emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  final regExp = RegExp(emailPattern);
  if (value == null || value.isEmpty) {
    return 'Veuillez entrer votre adresse e-mail';
  } else if (!regExp.hasMatch(value)) {
    return 'Adresse e-mail invalide';
  }
  return null;
}
