import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_icons.dart';
import 'package:feelps/app/core/theme/app_routes.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:feelps/app/core/utils/formatter.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:feelps/app/modules/components/scaffold/default_scaffold.dart';
import 'package:feelps/app/modules/home/presenter/components/change_status_bar_component.dart';
import 'package:feelps/app/modules/home/presenter/components/home_button_component.dart';
import 'package:feelps/app/modules/home/presenter/components/name_status_text_component.dart';
import 'package:feelps/app/modules/home/presenter/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authStore = Modular.get<AuthStore>();
  final controller = Modular.get<HomeController>();

  late Location location;

  @override
  void initState() {
    controller.getStatusAvaliable();
    location = Location();
    super.initState();
    requestPermission().then((value) {
      if (value) {
        location.changeSettings(
          interval: 20000,
        );
        location.onLocationChanged.listen((event) async {
          controller.updateLastLocation(
              latitude: event.latitude!, longitude: event.longitude!);
        });
      }
    });
  }

  Future<bool> requestPermission() async {
    var permissionStatus = await Location.instance.hasPermission();
    if (permissionStatus != PermissionStatus.granted &&
        permissionStatus != PermissionStatus.grantedLimited) {
      while (permissionStatus != PermissionStatus.granted &&
          permissionStatus != PermissionStatus.grantedLimited &&
          permissionStatus != PermissionStatus.deniedForever) {
        permissionStatus = await Location.instance.requestPermission();
        setState(() {});
      }
    }
    if (permissionStatus == PermissionStatus.deniedForever) {
      DefaultAlertDialog.show(
          dialogData: DialogDataEntity(
              title: "Ops.",
              description:
                  "Você não poderá realizar entregas sem permitir o uso da localização." +
                      "\nEntre nas configurações do seu celular em gerenciador de aplicativos, procure por Feelps e em seguida ative a localização!"));
      return false;
    }
    return true;
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
          height: MediaQuery.of(context).size.height * 0.74,
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
                  top: AppColumns.column6(context: context),
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
                                  Modular.to.pushNamed(AppRoutes.myData);
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
                  padding: EdgeInsets.only(
                      top: 16,
                      left: 26,
                      right: 19,
                      bottom:
                          MediaQuery.of(context).size.width > 350 ? 33 : 12),
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
                                          image: NetworkImage(
                                            authStore.deliveryman!.photoUrl,
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
                      onChangedAvaliable: (value) async {
                        final permissionStatus =
                            await Location.instance.hasPermission();
                        if (permissionStatus == PermissionStatus.denied) {
                          DefaultAlertDialog.show(
                              dialogData: DialogDataEntity(
                                  title: "Ops.",
                                  description:
                                      "Você não poderá realizar entregas sem permitir o uso da localização." +
                                          "\nEntre nas configurações do seu celular em gerenciador de aplicativos, procure por Feelps e em seguida ative a localização!"));
                        } else {
                          if (authStore.deliveryman!.motorcycle != null) {
                            if (authStore.deliveryman!.status!) {
                              await controller.isAvaliableChanged(value: value);
                            } else {
                              DefaultAlertDialog.show(
                                  dialogData: DialogDataEntity(
                                      title: "Ops.",
                                      description:
                                          "Você ainda não está habilitado a realizar entregas." +
                                              "\nSeu cadastro está sendo verificado!"));
                            }
                          } else {
                            DefaultAlertDialog.show(
                                dialogData: DialogDataEntity(
                                    title: "Ops.",
                                    description:
                                        "Você ainda não está habilitado a realizar entregas." +
                                            "\nCadastre uma motocicleta!"));
                          }
                        }
                      },
                    );
                  }),
                )
              ],
            ))
      ]),
    );
  }
}
