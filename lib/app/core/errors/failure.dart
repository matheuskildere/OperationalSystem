import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  String get title;
  String get message;
  @override
  List<Object?> get props => [title, message];
}
