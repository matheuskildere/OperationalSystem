import 'package:feelps/app/modules/components/button/default_back_button.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:feelps/app/modules/components/text/default_text_field.dart';
import 'package:feelps/app/modules/components/text/title_subtitle_component.dart';
import 'package:flutter/material.dart';
import 'package:feelps/app/modules/register/presenter/controller/register_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterPersonalDataPage extends StatefulWidget {
  const RegisterPersonalDataPage({ Key? key }) : super(key: key);

  @override
  _RegisterPersonalDataPageState createState() => _RegisterPersonalDataPageState();
}

class _RegisterPersonalDataPageState extends ModularState<RegisterPersonalDataPage, RegisterController> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25,),
          const DefaultBackButton(),
          const SizedBox(height: 20,),
          TitleSubtitleComponent(title: "Informe seus dados pessoais", subTitle: "Realizando cadastro!"),
          const SizedBox(height: 40,),
          DefaultTextField(
            labelText: "Nome completo",
            onChanged: (value)=> controller.fullName
          ),
          const SizedBox(height: 20,),
          DefaultTextField(
            labelText: "CPF",
          ),
          const SizedBox(height: 20,),
          DefaultTextField(
            labelText: "Número de celular",
          ),
          const SizedBox(height: 20,),
          DefaultTextField(
            labelText: "Data de nascimento",
          ),
        ],
      ),
      floatingActionButton: DefaultButton(onPressed: (){}, title: "Próximo passo"),
    );
  }
}