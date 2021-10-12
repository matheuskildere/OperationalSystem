import 'dart:async';

import 'package:feelps/app/core/enum/status_enum.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

String count = '10';

class ReceiveMessagingService {
  static bool instaceBackgrountCreated = false;
  Future<void> onReceiveMessage(
      {required RemoteMessage event, required bool fromBackground}) async {
    appFlavor = Flavor.prod;
    await Firebase.initializeApp();
    final notificationAt = DateTime.fromMillisecondsSinceEpoch(
        int.parse(event.data['notificationAt'].toString()));
    if (!fromBackground) {
      if (DateTime.now().difference(notificationAt).inSeconds <= 10) {
        DefaultAlertDialog.showService(
            value: event.data['value'].toString(),
            distance: event.data['distance'].toString(),
            serviceId: event.data['serviceId'] as String,
            pickupAddress: event.data['pickup_address'].toString(),
            deliveryAddress: event.data['delivery_address'].toString(),
            establishment: event.data['establishment'].toString());
      }
    } else {
      for (var i = 0; i < 20; i++) {
        await Future.delayed(Duration(seconds: 1));
        print(DateTime.now().difference(notificationAt).inSeconds);
        if (DateTime.now().difference(notificationAt).inSeconds > 9) {
          break;
        }
      }
      await Future.delayed(Duration(seconds: 9));
      await FirebaseDatabase.instance
          .reference()
          .child('service-${appFlavor!.title}')
          .child(event.data['serviceId'].toString())
          .child('status')
          .once()
          .then((value) {
        if (value.value ==
                DeliveryStatusEnum.serchingDeliveryMan.getDescription() ||
            value.value.toString().contains('rejected')) {
          FirebaseDatabase.instance
              .reference()
              .child('service-${appFlavor!.title}')
              .child(event.data['serviceId'].toString())
              .update({
            'status':
                'rejected-${FirebaseAuth.instance.currentUser!.uid}-${DateTime.now()}'
          });
        }
      });
    }
  }
}
