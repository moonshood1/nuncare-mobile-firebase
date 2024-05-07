String? validatePhone(String? value, String second) {
  const phonePattern = r'^\+\d{13}$';
  final regExp = RegExp(phonePattern);
  if (!regExp.hasMatch(value ?? '')) {
    return 'Format invalide (Ex: +2250101010101)';
  }
  return null;
}
