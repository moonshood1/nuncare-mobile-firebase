String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Veuillez entrer le mot de passe';
  } else if (value.length < 6) {
    return 'Le mot de passe doit contenir au moins 6 caractères';
  }
  return null;
}

String? validateRepeatedPassword(String? value, String mainPassword) {
  if (value == null || value.isEmpty) {
    return 'Veuillez repeter le mot de passe';
  } else if (value.length < 6) {
    return 'Le mot de passe doit contenir au moins 6 caractères';
  } else if (mainPassword.isNotEmpty && value != mainPassword.trim()) {
    return 'Les deux mots de passe ne sont pas identiques';
  }

  return null;
}
