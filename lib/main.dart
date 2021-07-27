import 'package:feelps/app/app_module.dart';
import 'package:feelps/app/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/core/services/receive_messaging_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  ReceiveMessagingService.onReceiveMessage(message);
}

Future<void> _firebaseMessagingForograundHandler(RemoteMessage message) async {
  ReceiveMessagingService.onReceiveMessage(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    ReceiveMessagingService.onReceiveMessage(event);
  });
  FirebaseMessaging.onMessage.listen(_firebaseMessagingForograundHandler);
  await initializeDateFormatting('p t_BR');
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
