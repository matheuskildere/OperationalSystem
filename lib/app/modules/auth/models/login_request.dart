import 'dart:convert';

class LoginRequest {
  final String email;
  final String password;

  LoginRequest(this.email, this.password);

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}
