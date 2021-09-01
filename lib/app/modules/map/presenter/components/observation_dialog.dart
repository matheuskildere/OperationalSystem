import 'package:asuka/asuka.dart' as asuka;
import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:flutter/material.dart';

class ObservationDialog {
  static Future showObservation(
          {required void Function(String?, void Function()) onTap,
          bool barrierDismissible = false}) =>
      asuka.showDialog(
          barrierDismissible: barrierDismissible,
          builder: (context) {
            String? observation;
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
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Observação",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: AppColors.black, fontSize: 15),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: 63,
                      child: Divider(
                        color: AppColors.secondary,
                        thickness: 3,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DefaultTextField(
                      maxLines: 7,
                      hintText: "Digite aqui",
                      onChanged: (value) => observation = value,
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
                            title: "Cancelar",
                            invertColors: true,
                            smallTitle: true,
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          width: AppColumns.column4(context: context),
                          child: DefaultButton(
                              title: "Confirmar",
                              smallTitle: true,
                              successColor: true,
                              onPressed: () async => onTap(
                                  observation, () => Navigator.pop(context))),
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
