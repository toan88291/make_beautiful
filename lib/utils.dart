class ValidateUtils {
  static final RegExp _passwordRegex =
  RegExp(r"^(?=.*?[a-zA-Z])(?=.*?[0-9]).{6,20}$");

  static bool isPassword(String pass) {
    return _passwordRegex.hasMatch(pass.trim());
  }
}