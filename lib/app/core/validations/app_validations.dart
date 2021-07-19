import 'package:feelps/app/core/validations/cpf_validator.dart';
import 'package:string_validator/string_validator.dart';

class AppValidations {
  static bool isCPFValid(String? cpf) {
    return CPFValidator.isValid(cpf);
  }

  static bool isEmailValid(String? email) {
    if (email != null) {
      return isEmail(email.trim());
    } else {
      return false;
    }
  }
}
