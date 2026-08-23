import 'package:dlibphonenumber/dlibphonenumber.dart' as dlib;

class AppValidators {
  static String? validateName(String? val) {
    if (val == null || val.trim().isEmpty) {
      return "Name is required";
    }

    if (val.trim().length < 2) {
      return "Name must be at least 2 characters";
    }

    if (!RegExp(r"^[a-zA-Z\u0600-\u06FF\s]+$").hasMatch(val)) {
      return "Please enter a valid name (letters only)";
    }

    return null;
  }

  static String? validateEmail(String? val) {
    if (val == null || val.isEmpty) {
      return "Email is required";
    }

    if (!RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$",
    ).hasMatch(val)) {
      return "Please enter a valid email address";
    }

    return null;
  }

  static String? validateBirthdate(String? val) {
    if (val == null || val.isEmpty) {
      return "Birthdate is required";
    }

    return null;
  }

  static String? validatePhone(
    String? val,
    String fullPhoneNumber,
    String countryCode,
  ) {
    if (val == null || val.trim().isEmpty) {
      return "Phone number is required";
    }

    try {
      final phoneUtil = dlib.PhoneNumberUtil.instance;
      final parsedPhone = phoneUtil.parse(fullPhoneNumber, countryCode);

      if (!phoneUtil.isValidNumber(parsedPhone)) {
        return "Please enter a valid phone number";
      }

      final numberType = phoneUtil.getNumberType(parsedPhone);
      if (numberType != dlib.PhoneNumberType.mobile &&
          numberType != dlib.PhoneNumberType.fixedLineOrMobile) {
        return "Please enter a valid mobile number";
      }

      return null;
    } catch (e) {
      return "Please enter a valid phone number";
    }
  }

  static String? validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return "Password is required";
    }

    if (val.length < 8) {
      return "Password must be at least 8 characters";
    }

    if (!RegExp(r'[A-Z]').hasMatch(val)) {
      return "Must contain at least one uppercase letter";
    }

    if (!RegExp(r'[a-z]').hasMatch(val)) {
      return "Must contain at least one lowercase letter";
    }

    if (!RegExp(r'[0-9]').hasMatch(val)) {
      return "Must contain at least one number";
    }

    if (!RegExp(r'[!@#\$&*~_=%^]+').hasMatch(val)) {
      return "Must contain at least one special character";
    }

    return null;
  }

  static String? validateConfirmPassword(String? val, String originalPassword) {
    if (val == null || val.isEmpty) {
      return "Confirm Password is required";
    }

    if (val != originalPassword) {
      return "Passwords don't match";
    }

    return null;
  }
}
