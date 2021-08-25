import 'package:feelps/app/core/errors/failure.dart';

class GetServiceInfoError extends Failure {
  final String title;
  final String message;
  GetServiceInfoError({required this.title, required this.message});
}
