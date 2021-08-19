class ObservationModel {
  final String status;
  final String observation;
  final String createdAt;

  ObservationModel(
      {required this.status,
      required this.observation,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'observation': observation,
      'createdAt': createdAt,
    };
  }

  factory ObservationModel.fromMap(Map<String, dynamic> map) {
    return ObservationModel(
      status: map['status'] as String,
      observation: map['observation'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}
