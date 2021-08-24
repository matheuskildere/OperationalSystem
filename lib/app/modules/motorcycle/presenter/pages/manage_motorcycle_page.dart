import 'package:feelps/app/core/entities/mtorcycle_entity.dart';
import 'package:feelps/app/core/enum/motorcycle_colors_enum.dart';
import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_icons.dart';
import 'package:feelps/app/core/theme/app_routes.dart';
import 'package:feelps/app/core/theme/app_typography.dart';
import 'package:feelps/app/modules/components/button/default_button.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:feelps/app/modules/motorcycle/presenter/components/big_title_component.dart';
import 'package:feelps/app/modules/motorcycle/presenter/components/motorcycle_data_component.dart';
import 'package:feelps/app/modules/motorcycle/presenter/controller/motorcycle_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ManageMotorcyclePage extends StatefulWidget {
  final MotorcycleEntity? motorcycle;
  const ManageMotorcyclePage({this.motorcycle});

  @override
  _ManageMotorcyclePageState createState() => _ManageMotorcyclePageState();
}

class _ManageMotorcyclePageState extends State<ManageMotorcyclePage> {
  final controller = Modular.get<MotorcycleController>();
  final authStore = Modular.get<AuthStore>();
  bool loading = true;

  @override
  void initState() {
    getMotorcycle();
    super.initState();
  }

  Future<void> getMotorcycle() async {
    await controller.getMotorcycle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Observer(
          builder: (context) {
            if (controller.errorMessage == null &&
                controller.motorcycle == null) {
              return Center(
                  child: SizedBox(
                      height: 200,
                      width: 200,
                      child: CircularProgressIndicator(
                        color: AppColors.secondary,
                        strokeWidth: 6,
                      )));
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 198,
                  width: double.infinity,
                  color: AppColors.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 27, top: 60, bottom: 23),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: AppIcon(
                            icon: AppIcons.arrowBack,
                            height: 15,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigTitleComponent(title: 'Gerenciar\nmotocicleta'),
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Observer(
                              builder: (context) {
                                return InkWell(
                                  onTap: () {
                                    controller.getImage();
                                  },
                                  child: Observer(
                                    builder: (context) {
                                      return Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage: controller
                                                        .currentPhoto !=
                                                    null
                                                ? FileImage(
                                                    controller.currentPhoto!)
                                                : controller.newPhoto == null
                                                    ? null
                                                    : FileImage(
                                                        controller.newPhoto!),
                                            backgroundColor:
                                                AppColors.lightGrey,
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            'Adicionar',
                                            style: AppTypography.cardText
                                                .copyWith(
                                                    fontSize: 13,
                                                    decoration: TextDecoration
                                                        .underline),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                if (controller.errorMessage != null &&
                    controller.motorcycle == null)
                  Container(
                    width: 332,
                    decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      child: Center(
                        child: Text(
                          controller.errorMessage!,
                          textAlign: TextAlign.center,
                          style: AppTypography.cardText,
                        ),
                      ),
                    ),
                  ),
                if (controller.motorcycle != null)
                  Container(
                    width: 360,
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 26.5,
                      left: 31,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.containerBackground,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MotorcycleDataComponent(
                          title: 'Marca',
                          subtitle: controller.motorcycle!.brand,
                        ),
                        MotorcycleDataComponent(
                          title: 'Modelo',
                          subtitle: controller.motorcycle!.model,
                        ),
                        MotorcycleDataComponent(
                          title: 'Ano',
                          subtitle: controller.motorcycle!.year.toString(),
                        ),
                        MotorcycleDataComponent(
                          title: 'Cor',
                          subtitle: controller.motorcycle!.color.getCor(),
                          trailing: CircleAvatar(
                              backgroundColor:
                                  controller.motorcycle!.color.getColor),
                        ),
                        MotorcycleDataComponent(
                          title: 'Placa',
                          subtitle: controller.motorcycle!.plate,
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      DefaultButton(
                        onPressed: () {
                          Modular.to.pushNamed(AppRoutes.registerMotorcycle);
                        },
                        title: 'Cadastrar Motocicleta',
                        icon: AppIcons.deliveryDining,
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      DefaultButton(
                        onPressed: () async {
                          await controller.deleteMotorcycle();
                        },
                        title: 'Apagar moto',
                        invertColors: true,
                        border: true,
                      ),
                      SizedBox(
                        height: 22,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
