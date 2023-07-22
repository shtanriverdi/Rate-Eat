class Validations {
  static String? validateFirstName(String? fullName) {
    RegExp regExp =
        RegExp(r"^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$");
    if (fullName?.isEmpty == 0) {
      return 'Please enter your first name!';
    }
    if (!regExp.hasMatch(fullName!)) {
      return "Invalid input";
    }
    return null;
  }

  static String? validateLastName(String? fullName) {
    RegExp regExp =
        RegExp(r"^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$");
    if (fullName?.length == 0) {
      return 'Please enter your last name!';
    }
    if (!regExp.hasMatch(fullName!)) {
      return "Invalid input";
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email?.length == 0) {
      return 'Please input an email!';
    }

    String new_e = email!.trim();

    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!regExp.hasMatch(new_e)) {
      return 'Invalid email!';
    }
  }

  static String? validatePassword(String? password) {
    RegExp regExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{5,}$');

    if (password?.length == 0) {
      return 'Please input password!';
    } else if (password!.length < 4) {
      return 'Password must be at least 4 characters';
    }
  }
}
