class AppValidation {
  static RegExp phoneNumberPatten = RegExp(r"^[0-9]");

  static RegExp emailPatten = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passPatten = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
  static loginEmailValidation(String? value) {
    if (value == null) {
      return null;
    } else if (value.isEmpty) {
      return "Enter your email";
    } else if (!emailPatten.hasMatch(value)) {
      return "Enter valid email";
    }
  }

  static loginPasswordValidation(String? value) {
    if (value == null) {
      return null;
    } else if (value.isEmpty) {
      return "Enter your password";
    } else {
      return null;
    }
  }

  static usernameValidation(String? value) {
    if (value == null) {
      return null;
    } else if (value.isEmpty) {
      return "Enter your name";
    } else {
      return null;
    }
  }

  static registerEmailValidation(String? value) {
    if (value == null) {
      return null;
    } else if (value.isEmpty) {
      return "Enter your email";
    } else if (!emailPatten.hasMatch(value)) {
      return "Enter valid email";
    } else {
      return null;
    }
  }

  static phoneValidation(String? value) {
    if (value == null) {
      return null;
    } else if (value.isEmpty) {
      return "Enter your phone number";
    } else if (!phoneNumberPatten.hasMatch(value)) {
      return "Enter valid phone number";
    } else {
      return null;
    }
  }

  static confirmPasswordValidation(String? value, String password) {
    if (value == null) {
      return null;
    } else if (value.isEmpty) {
      return "Enter your confirm password";
    } else if (value != password) {
      return "Enter valid confirm password";
    } else {
      return null;
    }
  }

  static registerPasswordValidation(String? value) {
    if (value == null) {
      return null;
    } else if (value.isEmpty) {
      return "Enter your password";
    } else if (!passPatten.hasMatch(value)) {
      return """
Minimum 8 characters, 
at least one uppercase letter, 
one lowercase letter, 
one number and one special character""";
    } else {
      return null;
    }
  }
}
