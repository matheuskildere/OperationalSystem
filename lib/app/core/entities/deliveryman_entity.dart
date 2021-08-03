import 'package:equatable/equatable.dart';

class DeliverymanEntity extends Equatable {
  final String? id;
  final String email;
  final String? password;
  final String fullName;
  final String phoneNumber;
  final DateTime birthday;
  final DateTime? createdAt;
  final String cpf;
  final String photoBase64;
  final bool? isAvaliable;
  final bool? status;

  const DeliverymanEntity({
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.birthday,
    required this.cpf,
    required this.photoBase64,
    this.createdAt,
    this.status,
    this.isAvaliable,
  });

  @override
  List<Object?> get props => [email, password, fullName];
}
