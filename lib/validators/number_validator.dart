String? validateNumber(String? value, String? label) {
  if (value == null || value.isEmpty) {
    return 'Veuillez entrer $label';
  }
  return null;
}
