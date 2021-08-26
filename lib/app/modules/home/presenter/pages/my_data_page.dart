import 'dart:typed_data';

import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:feelps/app/core/utils/data_parser.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:feelps/app/modules/home/presenter/components/title_subtitle_data_component.dart';
import 'package:feelps/app/modules/home/presenter/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MyDataPage extends StatefulWidget {
  const MyDataPage({Key? key}) : super(key: key);

  @override
  _MyDataPageState createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {
  final controller = Modular.get<HomeController>();
  final authStore = Modular.get<AuthStore>();
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        paddingValue: 0,
        backgroundColor: AppColors.white,
        withScroll: false,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                  height: AppColumns.column10(context: context),
                  child: Stack(children: [
                    Container(
                      height: AppColumns.column8(context: context),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                    ),
                    Positioned(
                        top: 60,
                        left: 31,
                        child: BackButton(
                          color: AppColors.white,
                        )),
                    Positioned.fill(
                      top: AppColumns.column3(context: context),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text('Meus dados',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: AppColors.white)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                            height: 142,
                            width: 142,
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: AppColors.secondary,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: MemoryImage(
                                      Uint8List.fromList(authStore
                                          .deliveryman!.photoUrl.codeUnits),
                                    ),
                                    fit: BoxFit.cover))),
                      ),
                    ),
                  ])),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 61,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleSubtitleDataComponent(
                          title: 'Nome',
                          subtitle: authStore.deliveryman!.fullName),
                      const SizedBox(
                        height: 20,
                      ),
                      TitleSubtitleDataComponent(
                          title: 'Data de nascimento',
                          subtitle: DateParser.getDateString(
                              authStore.deliveryman!.birthday)),
                      const SizedBox(
                        height: 20,
                      ),
                      TitleSubtitleDataComponent(
                          title: 'Está no aplicativo desde',
                          subtitle: DateParser.getDateString(
                              authStore.deliveryman!.createdAt)),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 21, right: 31, left: 31),
                child: DefaultButton(
                    invertColors: true,
                    border: true,
                    onPressed: () async {
                      await controller.isAvaliableChanged(value: false);
                      await authStore.logout();
                    },
                    title: 'Sair'),
              )
            ]));
  }
}
