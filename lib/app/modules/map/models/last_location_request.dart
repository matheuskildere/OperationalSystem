class LastLocationRequest {
  final double latitude;
  final double longitude;
  final String deliveryManId;
  LastLocationRequest({
    required this.latitude,
    required this.longitude,
    required this.deliveryManId,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
