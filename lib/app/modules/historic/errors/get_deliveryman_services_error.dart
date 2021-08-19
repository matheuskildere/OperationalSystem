import 'package:feelps/app/core/errors/failure.dart';

class GetDeliveryManServicesError extends Failure {
  final String title;
  final String message;
  GetDeliveryManServicesError({required this.title, required this.message});
}
