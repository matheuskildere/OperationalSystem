import 'package:feelps/app/core/entities/deliveryman_entity.dart';
import 'package:feelps/app/core/utils/data_parser.dart';

class DelvierymanResponse extends DeliverymanEntity {
  final String id;
  final String email;
  final String? password;
  final String fullName;
  final String phoneNumber;
  final DateTime birthday;
  final DateTime? createdAt;
  final String cpf;
  final String photoUrl;
  final bool status;
  final bool isAvaliable;

  const DelvierymanResponse({
    required this.id,
    required this.email,
    this.password,
    this.createdAt,
    required this.fullName,
    required this.phoneNumber,
    required this.birthday,
    required this.cpf,
    required this.photoUrl,
    required this.status,
    required this.isAvaliable,
  }) : super(
          id: id,
          birthday: birthday,
          cpf: cpf,
          email: email,
          fullName: fullName,
          password: password,
          createdAt: createdAt,
          phoneNumber: phoneNumber,
          photoUrl: photoUrl,
          status: status,
          isAvaliable: isAvaliable,
        );

  factory DelvierymanResponse.fromMap(Map<String, dynamic> map) {
    return DelvierymanResponse(
      id: map['id'].toString(),
      email: map['email'].toString(),
      fullName: map['fullName'].toString(),
      phoneNumber: map['phoneNumber'].toString(),
      birthday: DateParser.getDateTime(map['birthday'].toString()),
      createdAt: DateParser.getDateTime(map['createdAt'].toString()),
      cpf: map['cpf'].toString(),
      photoUrl: map['photoUrl'].toString(),
      status: map['status'] as bool,
      isAvaliable: map['isAvaliable'] as bool,
    );
  }
}
