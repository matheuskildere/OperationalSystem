import 'package:feelps/app/core/errors/failure.dart';

class RegisterMotorcycleError extends Failure {
  final String title;
  final String message;
  RegisterMotorcycleError({required this.title, required this.message});
}
