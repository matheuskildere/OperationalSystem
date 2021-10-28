import 'package:feelps/app/core/theme/app_routes.dart';
import 'package:feelps/app/core/utils/data_parser.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:feelps/app/modules/register/presenter/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterPersonalDataPage extends StatefulWidget {
  const RegisterPersonalDataPage({Key? key}) : super(key: key);

  @override
  _RegisterPersonalDataPageState createState() =>
      _RegisterPersonalDataPageState();
}

class _RegisterPersonalDataPageState
    extends ModularState<RegisterPersonalDataPage, RegisterController> {
  final dateTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          const DefaultBackButton(),
          const SizedBox(
            height: 20,
          ),
          TitleSubtitleComponent(
              title: "Informe seus dados pessoais",
              subTitle: "Realizando cadastro!"),
          const SizedBox(
            height: 40,
          ),
          DefaultTextField(
              labelText: "Nome completo",
              action: TextInputAction.next,
              onChanged: (value) => controller.fullName = value),
          const SizedBox(
            height: 20,
          ),
          DefaultTextField(
            labelText: "CPF",
            mask: '000.000.000-00',
            type: TextInputType.number,
            action: TextInputAction.next,
            onChanged: (value) => controller.cpf = value,
          ),
          const SizedBox(
            height: 20,
          ),
          DefaultTextField(
            labelText: "Número de celular",
            mask: '(00) 00000-0000',
            type: TextInputType.number,
            onChanged: (value) => controller.phoneNumber = value,
          ),
          const SizedBox(
            height: 20,
          ),
          DefaultTextField(
            labelText: 'Data de nascimento',
            readOnly: true,
            controller: dateTextController,
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(DateTime.now().year - 18),
                minDateTime: DateTime(1921),
                locale: DateTimePickerLocale.pt_br,
                dateFormat: 'dd-MMMM-yyyy',
                onConfirm: (dateTime, selectedIndex) async {
                  setState(() {
                    controller.birthday = dateTime;
                    dateTextController.text =
                        DateParser.getDateString(dateTime);
                  });
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: DefaultButton(
          onPressed: () {
            controller.formValidation();
            if (controller.dialogData != null) {
              DefaultAlertDialog.show(
                  barrierDismissible: true, dialogData: controller.dialogData!);
            } else {
              Modular.to.pushNamed(AppRoutes.registerUserdata);
            }
          },
          title: "Próximo passo"),
    );
  }
}
