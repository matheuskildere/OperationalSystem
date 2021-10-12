import 'package:feelps/app/app_module.dart';
import 'package:feelps/app/app_widget.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/core/services/receive_messaging_service.dart';

final receiveMessagingService = ReceiveMessagingService();
Future<void> _firebaseMessagingForograundHandler(RemoteMessage message) async {
  receiveMessagingService.onReceiveMessage(
      event: message, fromBackground: true);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appFlavor = Flavor.prod;
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingForograundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    receiveMessagingService.onReceiveMessage(
      event: event,
      fromBackground: false,
    );
  });
  FirebaseMessaging.onMessage
      .listen((event) => receiveMessagingService.onReceiveMessage(
            event: event,
            fromBackground: false,
          ));
  await initializeDateFormatting('p t_BR');
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
