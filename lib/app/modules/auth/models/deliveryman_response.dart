import 'package:feelps/app/core/entities/deliveryman_entity.dart';
import 'package:feelps/app/core/utils/data_parser.dart';

class DelvierymanResponse extends DeliverymanEntity {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final DateTime birthday;
  final String cpf;
  final String photoBase64;

  const DelvierymanResponse({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.birthday,
    required this.cpf,
    required this.photoBase64,
  }) : super(
            birthday: birthday,
            cpf: cpf,
            email: email,
            fullName: fullName,
            password: password,
            phoneNumber: phoneNumber,
            photoBase64: photoBase64);

  factory DelvierymanResponse.fromMap(Map<String, dynamic> map) {
    return DelvierymanResponse(
      email: map['email'].toString(),
      fullName: map['fullName'].toString(),
      password: "",
      phoneNumber: map['phoneNumber'].toString(),
      birthday: DateParser.getDateTime(map['birthday'].toString()),
      cpf: map['cpf'].toString(),
      photoBase64: map['photoBase64'].toString(),
    );
  }
}
