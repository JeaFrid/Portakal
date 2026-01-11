class PortakalValidator {
  static String? email(String? value, {String? message}) {
    if (value == null || value.isEmpty) return message ?? 'Email required';
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value);
    return emailValid ? null : (message ?? 'Invalid email format');
  }

  static String? password(String? value, {int minLength = 6, String? message}) {
    if (value == null || value.isEmpty) return 'Password required';
    if (value.length < minLength) {
      return message ??
          'The password must be at least $minLength in characters.';
    }
    return null;
  }

  static String? required(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'This field is required';
    }
    return null;
  }

  static String? phone(String? value, {String? message}) {
    if (value == null || value.isEmpty) return message ?? 'phone required';
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return message ?? 'Invalid phone number';
    }
    return null;
  }
}
