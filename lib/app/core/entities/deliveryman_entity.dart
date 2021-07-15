import 'package:equatable/equatable.dart';

class Deliveryman extends Equatable {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final DateTime birthday;
  final String cpf;
  final String photoBase64;

  const Deliveryman({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.birthday,
    required this.cpf,
    required this.photoBase64,
  });

  @override
  List<Object?> get props => [email,
    password,
    fullName];
}
