import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class Formatter {
  static String moneySettings(String value, {String leadingSymbol = 'R\$'}) {
    return toCurrencyString(value,
        leadingSymbol: leadingSymbol,
        useSymbolPadding: true,
        thousandSeparator: ThousandSeparator.Period);
  }

  static String phoneWithOutFormatter(String phone) {
    return phone
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('-', '')
        .trim();
  }

  static String cpfWithOutFormatter(String cpf) {
    return cpf.replaceAll('.', '').replaceAll('-', '').trim();
  }

  static String upperCaseAllFirstLetters(String value) {
    final list = value.split(' ');
    final listUper = list
        .map((e) => e.substring(0, 1).toUpperCase() + e.substring(1))
        .toList();
    return listUper.join(' ');
  }
}
