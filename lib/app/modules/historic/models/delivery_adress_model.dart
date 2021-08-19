class DeliveryAdressModel {
  final String receiver;
  final String adress;
  final double latitude;
  final double longitude;

  DeliveryAdressModel(
      {required this.receiver,
      required this.adress,
      required this.latitude,
      required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'receiver': receiver,
      'adress': adress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory DeliveryAdressModel.fromMap(Map<String, dynamic> map) {
    return DeliveryAdressModel(
      receiver: map['receiver'] as String,
      adress: map['adress'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }
}
