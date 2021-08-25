import 'package:feelps/app/core/entities/service_entity.dart';

class LocationModel extends LocationEntity {
  final double latitude;
  final double longitude;

  LocationModel({
    required this.latitude,
    required this.longitude,
  }) : super(latitude: latitude, longitude: longitude);

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      latitude: double.parse(map['latitude'].toString()),
      longitude: double.parse(map['longitude'].toString()),
    );
  }
}
