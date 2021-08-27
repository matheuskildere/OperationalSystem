import 'package:feelps/app/modules/components/components.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ReceiveMessagingService {
  static void onReceiveMessage(RemoteMessage event) {
    DefaultAlertDialog.showService(
        value: event.data['value'].toString(),
        distance: event.data['distance'].toString(),
        serviceId: event.data['serviceId'] as String,
        pickupAddress: event.data['pickup_address'].toString(),
        deliveryAddress: event.data['delivery_address'].toString());
  }
}
