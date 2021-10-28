import 'package:feelps/app/core/errors/failure.dart';

class GetLoggedUserError extends Failure {
  final String title;
  final String message;
  GetLoggedUserError({required this.title, required this.message});
}

class AuthError extends Failure {
  final String title;
  final String message;
  AuthError({required this.title, required this.message});
}

class UserNotLoggedError extends Failure {
  final String title;
  final String message;
  UserNotLoggedError({required this.title, required this.message});
}

class LogoutError extends Failure {
  final String title;
  final String message;
  LogoutError({required this.title, required this.message});
}
