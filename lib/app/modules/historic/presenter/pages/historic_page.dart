import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_icons.dart';
import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/modules/historic/presenter/components/big_title_component.dart';
import 'package:feelps/app/modules/historic/presenter/components/expandable_container.dart';
import 'package:feelps/app/modules/historic/presenter/controller/historic_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({Key? key}) : super(key: key);

  @override
  _HistoricPageState createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  final controller = Modular.get<HistoricController>();
  final colorController = TextEditingController();

  bool loading = true;

  @override
  void initState() {
    getServices();
    super.initState();
  }

  Future<void> getServices() async {
    await controller.getServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Observer(builder: (context) {
          if (controller.errorMessage == null && controller.services == null) {
            return Center(
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: AppColors.secondary,
                      strokeWidth: 6,
                    )));
          }

          return SizedBox(
              child: SingleChildScrollView(
            child: Column(
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
                          BigTitleComponent(title: 'Histórico de\nserviços'),
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Observer(
                              builder: (context) {
                                return AppIcon(
                                  icon: AppIcons.union,
                                  height: 27,
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
                Observer(
                  builder: (context) {
                    return Column(
                      children: [
                        if (controller.errorMessage != null ||
                            (controller.services != null &&
                                controller.services!.isEmpty))
                          Container(
                            width: 332,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 16),
                              child: Center(
                                child: Text(
                                  controller.errorMessage != null
                                      ? controller.errorMessage!
                                      : 'Não há serviços registrados ainda!',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.cardText,
                                ),
                              ),
                            ),
                          )
                        else
                          Column(
                              children: controller.services!
                                  .map((service) =>
                                      ExpandableContainer(service: service))
                                  .toList())
                      ],
                    );
                  },
                ),
              ],
            ),
          ));
        }));
  }
}
