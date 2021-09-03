import 'package:equatable/equatable.dart';

import 'package:feelps/app/core/entities/mtorcycle_entity.dart';

class DeliverymanEntity extends Equatable {
  final String? id;
  final String email;
  final String? password;
  final String fullName;
  final String phoneNumber;
  final DateTime birthday;
  final DateTime? createdAt;
  final String cpf;
  final String photoUrl;
  final bool? isAvaliable;
  final bool? status;
  final MotorcycleEntity? motorcycle;

  const DeliverymanEntity({
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.birthday,
    required this.cpf,
    required this.photoUrl,
    this.createdAt,
    this.status,
    this.isAvaliable,
    this.motorcycle,
  });

  @override
  List<Object?> get props => [email, password, fullName];

  DeliverymanEntity copyWith({
    String? id,
    String? email,
    String? password,
    String? fullName,
    String? phoneNumber,
    DateTime? birthday,
    DateTime? createdAt,
    String? cpf,
    String? photoUrl,
    bool? isAvaliable,
    bool? status,
    MotorcycleEntity? motorcycle,
  }) {
    return DeliverymanEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthday: birthday ?? this.birthday,
      createdAt: createdAt ?? this.createdAt,
      cpf: cpf ?? this.cpf,
      photoUrl: photoUrl ?? this.photoUrl,
      isAvaliable: isAvaliable ?? this.isAvaliable,
      status: status ?? this.status,
      motorcycle: motorcycle,
    );
  }
}
