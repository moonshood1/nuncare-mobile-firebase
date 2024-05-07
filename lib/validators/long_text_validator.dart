String? validateLongText(String? value, String? label) {
  if (value == null || value.isEmpty) {
    return 'Veuillez entrer $label';
  } else if (value.length < 20) {
    return '$label doit contenir au moins 20 caractères';
  }
  return null;
}
