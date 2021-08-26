import 'dart:typed_data';

import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_icons.dart';
import 'package:feelps/app/core/theme/app_routes.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:feelps/app/core/utils/formatter.dart';
import 'package:feelps/app/modules/components/scaffold/default_scaffold.dart';
import 'package:feelps/app/modules/home/presenter/components/change_status_bar_component.dart';
import 'package:feelps/app/modules/home/presenter/components/home_button_component.dart';
import 'package:feelps/app/modules/home/presenter/components/name_status_text_component.dart';
import 'package:feelps/app/modules/home/presenter/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authStore = Modular.get<AuthStore>();
  final controller = Modular.get<HomeController>();

  @override
  void initState() {
    controller.getStatusAvaliable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      paddingValue: 0,
      backgroundColor: AppColors.white,
      withScroll: false,
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
              Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Stack(
            children: [
              Observer(builder: (context) {
                return Container(
                  height: AppColumns.column8(context: context),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: controller.isAvaliable
                          ? AppColors.success
                          : AppColors.primary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                );
              }),
              Observer(builder: (context) {
                return Positioned(
                    top: 68,
                    left: 49,
                    right: 49,
                    child: NameStatusTextComponent(
                        name: Formatter.upperCaseAllFirstLetters(
                            authStore.deliveryman!.fullName.split(' ').last),
                        status: controller.isAvaliable));
              }),
              Observer(builder: (context) {
                return Positioned(
                    top: 25,
                    right: 25,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: controller.isAvaliable
                              ? AppColors.white
                              : AppColors.secondary,
                          shape: BoxShape.circle),
                      child: AppIcon(
                        icon: AppIcons.logout,
                        width: 16,
                        height: 16,
                        fit: BoxFit.scaleDown,
                        onTap: () async {
                          await controller.isAvaliableChanged(value: false);
                          await authStore.logout();
                        },
                      ),
                    ));
              }),
              Positioned(
                  top: 204,
                  left: 49,
                  right: 49,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HomeButtonComponent(
                                isAvailable: false,
                                title: 'Meus dados',
                                icon: AppIcons.ninja,
                                onPress: () {
                                  Modular.to.pushNamed(AppRoutes.mapRoute);
                                }),
                            HomeButtonComponent(
                                isAvailable: false,
                                title: 'Minha moto',
                                icon: AppIcons.motocicle,
                                onPress: () {
                                  Modular.to.pushNamed(AppRoutes.motorcycle);
                                })
                          ]),
                      SizedBox(
                        height: 21,
                      ),
                      HomeButtonComponent(
                          isAvailable: false,
                          title: 'Corridas',
                          icon: AppIcons.horse,
                          onPress: () {
                            Modular.to.pushNamed(AppRoutes.historic);
                          })
                    ],
                  )),
            ],
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: Color(0xFFFCFCFC),
            child: Column(
              children: [
                Divider(
                  color: Color(0xFFEAE8E8),
                  height: 0,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 16, left: 26, right: 19, bottom: 33),
                  child: Observer(builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Container(
                                  height: 29,
                                  width: 29,
                                  decoration: BoxDecoration(
                                      color: AppColors.secondary,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: MemoryImage(
                                            Uint8List.fromList(authStore
                                                .deliveryman!
                                                .photoUrl
                                                .codeUnits),
                                          ),
                                          fit: BoxFit.cover))),
                              SizedBox(
                                width: 11,
                              ),
                              Flexible(
                                child: Text(
                                    Formatter.upperCaseAllFirstLetters(
                                        authStore.deliveryman!.fullName),
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .copyWith(fontSize: 21)),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  color: controller.isAvaliable
                                      ? AppColors.success
                                      : AppColors.primary,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              controller.isAvaliable
                                  ? 'Disponível'
                                  : 'Indisponível',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: controller.isAvaliable
                                      ? AppColors.success
                                      : AppColors.primary),
                            )
                          ],
                        )
                      ],
                    );
                  }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19),
                  child: Observer(builder: (context) {
                    return ChangeSatatusBarComponent(
                      isAvaliable: controller.isAvaliable,
                      onChangedAvaliable: (value) async =>
                          controller.isAvaliableChanged(value: value),
                    );
                  }),
                )
              ],
            ))
      ]),
    );
  }
}
