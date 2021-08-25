import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/utils/data_parser.dart';

class ObservationModel extends ObservationEntity {
  final String status;
  final String observation;
  final DateTime createdAt;

  ObservationModel(
      {required this.status,
      required this.observation,
      required this.createdAt})
      : super(status: status, observation: observation, createdAt: createdAt);

  factory ObservationModel.fromMap(Map<String, dynamic> map) {
    return ObservationModel(
      status: map['status'] as String,
      observation: map['observation'] as String,
      createdAt: DateParser.getDateTime(map['createdAt'].toString()),
    );
  }
}
