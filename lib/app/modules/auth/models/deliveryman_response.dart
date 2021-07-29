import 'package:feelps/app/core/entities/deliveryman_entity.dart';
import 'package:feelps/app/core/utils/data_parser.dart';

class DelvierymanResponse extends DeliverymanEntity {
  final String id;
  final String email;
  final String? password;
  final String fullName;
  final String phoneNumber;
  final DateTime birthday;
  final String cpf;
  final String photoBase64;
  final bool status;
  final bool isAvaliable;

  const DelvierymanResponse({
    required this.id,
    required this.email,
    this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.birthday,
    required this.cpf,
    required this.photoBase64,
    required this.status,
    required this.isAvaliable,
  }) : super(
          id: id,
          birthday: birthday,
          cpf: cpf,
          email: email,
          fullName: fullName,
          password: password,
          phoneNumber: phoneNumber,
          photoBase64: photoBase64,
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
      cpf: map['cpf'].toString(),
      photoBase64: map['photoBase64'].toString(),
      status: map['status'] as bool,
      isAvaliable: map['isAvaliable'] as bool,
    );
  }
}
