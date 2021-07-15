import 'dart:convert';

import 'package:feelps/app/core/entities/deliveryman_entity.dart';

class RegisterRequest extends Deliveryman {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final DateTime birthday;
  final String cpf;
  final String photoBase64;
  
  const RegisterRequest(
    this.email,
    this.password,
    this.fullName,
    this.phoneNumber,
    this.birthday,
    this.cpf,
    this.photoBase64,
  ): super(birthday: birthday, cpf: cpf, email: email,
    fullName: fullName, password: password,
    phoneNumber: phoneNumber, photoBase64: photoBase64);


  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'birthday': birthday.millisecondsSinceEpoch,
      'cpf': cpf,
      'photoBase64': photoBase64,
    };
  }

  String toJson() => json.encode(toMap());
}
