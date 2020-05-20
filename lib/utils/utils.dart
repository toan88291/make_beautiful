class ValidateUtils {
  static final RegExp _passwordRegex =
  RegExp(r"^(?=.*?[a-zA-Z])(?=.*?[0-9]).{6,20}$");

  static final RegExp _titleRegex =
  RegExp(r"^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[.]).{0,100}$");

  static bool isPassword(String pass) {
    return _passwordRegex.hasMatch(pass.trim());
  }

  static bool isTitle(String pass) {
    return _titleRegex.hasMatch(pass.trim());
  }

}