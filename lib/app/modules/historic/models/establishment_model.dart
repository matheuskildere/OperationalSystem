class EstablishmentModel {
  final String id;
  final String name;
  final String address;
  final String latitude;
  final String longitude;

  EstablishmentModel(
      {required this.id,
      required this.name,
      required this.address,
      required this.latitude,
      required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory EstablishmentModel.fromMap(Map<String, dynamic> map) {
    return EstablishmentModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }
}
