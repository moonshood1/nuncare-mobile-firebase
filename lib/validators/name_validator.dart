String? validateName(String? value, String? label) {
  if (value == null || value.isEmpty) {
    return 'Veuillez entrer $label';
  } else if (value.length < 4) {
    return '$label doit contenir au moins 4 caractères';
  }
  return null;
}
