import 'dart:async';

import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter_modular/flutter_modular.dart';

class DefaultAlertDialog {
  static Future show(
          {required DialogDataEntity dialogData,
          bool barrierDismissible = false}) =>
      asuka.showDialog(
          barrierDismissible: barrierDismissible,
          builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                insetPadding: EdgeInsets.all(33),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppIcon(
                            icon: dialogData.icon ?? AppIcons.warning,
                            color: dialogData.icon == AppIcons.warning ||
                                    dialogData.icon == null
                                ? AppColors.warning
                                : dialogData.icon == AppIcons.checkCircle
                                    ? AppColors.success
                                    : AppColors.error,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dialogData.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: AppColors.black),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  dialogData.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: AppColors.grey),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          AppIcon(
                            icon: AppIcons.close,
                            color: AppColors.grey,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  static String count = '10';
  static bool instaceCreated = false;
  static Future showService(
          {required String value,
          required String distance,
          required String serviceId,
          required String pickupAddress,
          required String deliveryAddress,
          bool barrierDismissible = false}) =>
      asuka.showDialog(
          barrierDismissible: barrierDismissible,
          builder: (context) {
            if (!instaceCreated) {
              instaceCreated = true;
              final interval = const Duration(seconds: 1);
              final int timerMaxSeconds = 10;
              int currentSeconds = 0;
              final duration = interval;
              Timer.periodic(duration, (timer) {
                currentSeconds = timer.tick;
                count = ((timerMaxSeconds - currentSeconds) % 60)
                    .toString()
                    .padLeft(2, '0');
                if (timer.tick >= timerMaxSeconds) timer.cancel();
                if (instaceCreated) {
                  print("bateu aqui");
                  (context as Element).markNeedsBuild();
                  if (count == "00") {
                  print("bateu aqui 2");
                    count = '10';
                    instaceCreated = false;
                    FirebaseDatabase.instance.reference()
                        .child('service-${appFlavor!.title}').child(serviceId)
                        .update({'status': 'rejected'});
                    Navigator.pop(context);
                  }
                } else {
                  print("aqui bateu só no final");
                  timer.cancel();
                }
              });
            }
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              insetPadding: EdgeInsets.all(33),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppIcon(
                          icon: AppIcons.deliveryDiningRounded,
                          color: AppColors.secondary,
                          width: 35,
                          fit: BoxFit.cover,
                          height: 35,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Flexible(
                          child: Text(
                            "Nova corrida avistada!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: AppColors.black),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 41),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Valor: $value",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: AppColors.black, fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Distância: $distance",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: AppColors.black, fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Retirada",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: AppColors.black, fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 63,
                            child: Divider(
                              color: AppColors.secondary,
                              thickness: 3,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Text(
                            pickupAddress,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: AppColors.black, fontSize: 15),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Entrega",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: AppColors.black, fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 63,
                            child: Divider(
                              color: AppColors.secondary,
                              thickness: 3,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Text(
                            deliveryAddress,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: AppColors.black, fontSize: 15),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: AppColumns.column4(context: context),
                          child: DefaultButton(
                            title: "Recusar ($count s)",
                            invertColors: true,
                            smallTitle: true,
                            onPressed: () async {
                              count = '10';
                              instaceCreated = false;
                              await FirebaseDatabase.instance.reference()
                                .child('service-${appFlavor!.title}').child(serviceId)
                                .update({'status': 'rejected'});
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          width: AppColumns.column4(context: context),
                          child: DefaultButton(
                            title: "Aceitar",
                            smallTitle: true,
                            successColor: true,
                            onPressed: () {
                              count = '10';
                              instaceCreated = false;
                              Navigator.pop(context);
                              Modular.to
                                  .navigate('${AppRoutes.mapRoute}/$serviceId');
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          });
}
