import 'package:feelps/app/core/errors/failure.dart';

class ChangeStatusError extends Failure {
  final String title;
  final String message;
  ChangeStatusError({required this.title, required this.message});
}
