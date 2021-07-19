import 'package:feelps/app/core/errors/failure.dart';

class RegisterError extends Failure {
  final String title;
  final String message;
  RegisterError({required this.title, required this.message});
}

class EmailAlreadyUsedError extends Failure {
  final String title;
  final String message;
  EmailAlreadyUsedError({required this.title, required this.message});
}
