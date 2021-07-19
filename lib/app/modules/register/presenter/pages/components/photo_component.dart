import 'dart:io';

import 'package:feelps/app/core/theme/app_shadows.dart';
import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:flutter/material.dart';

class PhotoComponent extends StatelessWidget {
  final File? photo;
  const PhotoComponent({Key? key, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppColumns.column5(context: context) * 0.96,
        height: AppColumns.column5(context: context) * 0.96,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppShadows.defaultBoxShadow,
            image: photo != null
                ? DecorationImage(image: FileImage(photo!), fit: BoxFit.cover)
                : null),
        child: photo == null
            ? AppIcon(
                icon: AppIllustrations.cameraPana,
                width: AppColumns.column4(context: context) * 0.91,
                height: AppColumns.column4(context: context) * 0.91,
              )
            : null,
      ),
    );
  }
}
