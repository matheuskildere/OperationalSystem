import 'package:equatable/equatable.dart';

class DialogDataEntity extends Equatable {
  final String title;
  final String description;
  final String? icon;

  const DialogDataEntity({
    required this.title,
    required this.description,
    this.icon,
  });

  @override
  List<Object?> get props => [title, description];
}
