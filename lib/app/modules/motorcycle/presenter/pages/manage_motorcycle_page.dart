import 'package:feelps/app/modules/components/components.dart';
import 'package:feelps/app/modules/motorcycle/presenter/components/big_title_component.dart';
import 'package:flutter/material.dart';

class ManageMotorcyclePage extends StatefulWidget {
  const ManageMotorcyclePage({Key? key}) : super(key: key);

  @override
  _ManageMotorcyclePageState createState() => _ManageMotorcyclePageState();
}

class _ManageMotorcyclePageState extends State<ManageMotorcyclePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        withBackAction: true,
        body: Column(
          children: [
            BigTitleComponent(title: 'Cadastrar\nmotocicleta'),
          ],
        ));
  }
}
