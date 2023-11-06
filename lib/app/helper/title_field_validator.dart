String? nameFieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a name';
  }
  if (value.length > 50) {
    return 'Title cannot be longer than 50 characters';
  }
  return null;
}

String? roleFieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select a role';
  }

  return null;
}
