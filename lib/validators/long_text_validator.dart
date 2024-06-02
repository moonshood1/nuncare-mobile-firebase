String? validateLongText(String? value, String? label, double limit) {
  if (value == null || value.isEmpty) {
    return 'Veuillez entrer $label';
  } else if (value.length < limit) {
    return '$label doit contenir au moins $limit caractères';
  }
  return null;
}
