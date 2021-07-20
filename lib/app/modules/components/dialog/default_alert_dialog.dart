import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/modules/components/button/default_button.dart';
import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;

class DefaultAlertDialog {
  static Future show(
          {List<DefaultButton>? listButtons,
          required DialogDataEntity dialogData,
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
}
