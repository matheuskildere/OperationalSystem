import 'package:feelps/app/core/errors/failure.dart';

class GetDirectionsInfoError extends Failure {
  final String title;
  final String message;
  GetDirectionsInfoError({required this.title, required this.message});
}

class NoRouteAvailableError extends Failure {
  final String title;
  final String message;
  NoRouteAvailableError({required this.title, required this.message});
}

class ServiceCanceledError extends Failure {
  final String title;
  final String message;
  ServiceCanceledError({required this.title, required this.message});
}
