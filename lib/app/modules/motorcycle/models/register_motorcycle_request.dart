class RegistermotorcycleRequest {
  final String brand;
  final String model;
  final int year;
  final String photoBase64;
  final String color;
  final String plate;

  RegistermotorcycleRequest(
      {required this.brand,
      required this.model,
      required this.year,
      required this.photoBase64,
      required this.color,
      required this.plate});

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'model': model,
      'year': year,
      'photoBase64': photoBase64,
      'color': color,
      'plate': plate,
    };
  }

  factory RegistermotorcycleRequest.fromMap(Map<String, dynamic> map) {
    return RegistermotorcycleRequest(
      brand: map['brand'] as String,
      model: map['model'] as String,
      year: map['year'] as int,
      photoBase64: map['photoBase64'] as String,
      color: map['color'] as String,
      plate: map['plate'] as String,
    );
  }
}
