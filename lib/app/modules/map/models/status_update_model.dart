class StatusUpdateModel {
  final String status;
  final String? observation;
  final String serviceId;
  StatusUpdateModel({
    required this.status,
    this.observation,
    required this.serviceId,
  });
}
