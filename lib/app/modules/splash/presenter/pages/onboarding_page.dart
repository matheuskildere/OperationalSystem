import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      withScroll: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bem vindo ao",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: AppColors.black),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Feelps Devlivery!",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: AppColors.black),
                    ),
                  ),
                ],
              ),
              AppIcon(
                appIconType: AppIconType.png,
                icon: AppImages.logoPrincipal,
                width: AppColumns.column3(context: context) * 1.1,
                height: AppColumns.column3(context: context) * 1.1,
              )
            ],
          ),
          Column(
            children: [
              AppIcon(
                icon: AppIllustrations.delivery,
                appIconType: AppIconType.png,
                width: AppColumns.column7(context: context) * 1.1,
                height: AppColumns.column7(context: context) * 1.1,
              ),
              Text(
                'O sabor da vida depende de quem tempera, e da sua entrega!',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AppColors.black),
              ),
            ],
          ),
          Column(
            children: [
              DefaultButton(
                  onPressed: () {
                    Modular.to.pushNamed(AppRoutes.register);
                  },
                  title: 'Iniciar'),
              SizedBox(
                height: 15,
              ),
              DefaultButton(
                  invertColors: true,
                  onPressed: () {
                    Modular.to.pushNamed(AppRoutes.auth);
                  },
                  title: 'Tenho uma conta'),
              SizedBox(
                height: 40,
              )
            ],
          )
        ],
      ),
    );
  }
}
