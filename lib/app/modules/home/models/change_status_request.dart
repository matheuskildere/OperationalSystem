import 'dart:convert';

class ChangeStatusRequest {
  final String deliveryManId;
  final bool isAvaliable;

  ChangeStatusRequest({required this.deliveryManId, required this.isAvaliable});

  Map<String, dynamic> toMap() {
    return {
      'isAvaliable': isAvaliable,
    };
  }

  String toJson() => json.encode(toMap());
}
