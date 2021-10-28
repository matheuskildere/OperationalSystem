import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_icons.dart';
import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:feelps/app/modules/motorcycle/models/motorcicly_color_model.dart';
import 'package:feelps/app/modules/motorcycle/presenter/components/big_title_component.dart';
import 'package:feelps/app/modules/motorcycle/presenter/components/color_menu_item_component.dart';
import 'package:feelps/app/modules/motorcycle/presenter/controller/motorcycle_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterMotorcyclePage extends StatefulWidget {
  const RegisterMotorcyclePage({Key? key}) : super(key: key);

  @override
  _RegisterMotorcyclePageState createState() => _RegisterMotorcyclePageState();
}

class _RegisterMotorcyclePageState extends State<RegisterMotorcyclePage> {
  final controller = Modular.get<MotorcycleController>();
  final colorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 198,
            width: double.infinity,
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 27, top: 60, bottom: 23),
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
                    BigTitleComponent(title: 'Cadastrar\nmotocicleta'),
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Observer(
                        builder: (context) {
                          return InkWell(
                            onTap: () {
                              controller.getImage();
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: controller.newPhoto == null
                                      ? null
                                      : FileImage(controller.newPhoto!),
                                  backgroundColor: AppColors.background,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'Adicionar',
                                  style: AppTypography.cardText.copyWith(
                                      fontSize: 13,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
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
          SizedBox(
            height: 42,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: DefaultTextField(
                      labelText: 'Marca',
                      action: TextInputAction.next,
                      onChanged: (value) {
                        controller.brand = value;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: DefaultTextField(
                      labelText: 'Modelo',
                      action: TextInputAction.next,
                      onChanged: (value) {
                        controller.model = value;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: DefaultTextField(
                      labelText: 'Ano',
                      type: TextInputType.number,
                      action: TextInputAction.done,
                      onChanged: (value) {
                        controller.year = int.parse(value);
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 26),
                  child: PopupMenuButton(
                    elevation: 2,
                    onSelected: (value) {
                      controller.color = value! as MotorciclyColorModel;
                      colorController.text = controller.color!.getCor();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    itemBuilder: (context) =>
                        List.generate(controller.colors.length, (index) {
                      return PopupMenuItem(
                        value: controller.colors[index],
                        child: ColorMenuItem(
                          color: controller.colors[index].getColor(),
                          colorName: controller.colors[index].getCor(),
                        ),
                      );
                    }).toList(),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: DefaultTextField(
                              enabled: false,
                              controller: colorController,
                              labelText: 'Cor',
                            ),
                          ),
                        ),
                        SizedBox(width: 21),
                        Observer(
                          builder: (context) {
                            return CircleAvatar(
                              backgroundColor: controller.color == null
                                  ? AppColors.background
                                  : controller.color!.getColor(),
                              radius: 25,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: DefaultTextField(
                      textCapitalization: TextCapitalization.characters,
                      mask: 'AAA 0*00',
                      labelText: 'Placa',
                      action: TextInputAction.done,
                      onChanged: (value) {
                        controller.plate = value;
                      }),
                ),
                DefaultButton(
                  onPressed: () async {
                    controller.formValidation();
                    if (controller.dialogData != null) {
                      DefaultAlertDialog.show(
                          barrierDismissible: true,
                          dialogData: controller.dialogData!);
                    } else {
                      await controller.registerMotorcycle();
                    }
                  },
                  title: 'Cadastrar',
                  icon: AppIcons.deliveryDining,
                ),
                SizedBox(
                  height: 26,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
