import 'dart:math';

class CPFValidator {
  static const List<String> blacklist = [
    "00000000000",
    "11111111111",
    "22222222222",
    "33333333333",
    "44444444444",
    "55555555555",
    "66666666666",
    "77777777777",
    "88888888888",
    "99999999999",
    "12345678909"
  ];

  static const stripRegex = r'[^\d]';

  // Compute the Verifier Digit (or "DÃ­gito Verificador (DV)" in PT-BR).
  // You can learn more about the algorithm on [wikipedia (pt-br)](https://pt.wikipedia.org/wiki/D%C3%ADgito_verificador)
  static int _verifierDigit(String cpf) {
    final List<int> numbers =
        cpf.split("").map((number) => int.parse(number, radix: 10)).toList();

    final modulus = numbers.length + 1;

    final List<int> multiplied = [];

    for (var i = 0; i < numbers.length; i++) {
      multiplied.add(numbers[i] * (modulus - i));
    }

    final int mod = multiplied.reduce((buffer, number) => buffer + number) % 11;

    return mod < 2 ? 0 : 11 - mod;
  }

  static String format(String cpf) {
    final RegExp regExp = RegExp(r'^(\d{3})(\d{3})(\d{3})(\d{2})$');

    return strip(cpf).replaceAllMapped(
        regExp, (Match m) => "${m[1]}.${m[2]}.${m[3]}-${m[4]}");
  }

  static String strip(String? cpf) {
    final RegExp regExp = RegExp(stripRegex);
    final newCpf = cpf ?? "";

    return newCpf.replaceAll(regExp, "");
  }

  static bool isValid(String? cpf, {bool stripBeforeValidation = true}) {
    String? newCpf;
    if (stripBeforeValidation) {
      newCpf = strip(cpf);
    }

    // CPF must be defined
    if (newCpf == null || cpf!.isEmpty) {
      return false;
    }

    // CPF must have 11 chars
    if (cpf.length != 11) {
      return false;
    }

    // CPF can't be blacklisted
    if (blacklist.contains(cpf)) {
      return false;
    }

    String numbers = cpf.substring(0, 9);
    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();

    return numbers.substring(numbers.length - 2) ==
        cpf.substring(cpf.length - 2);
  }

  static String generate({bool useFormat = false}) {
    String numbers = "";
    final buffer = StringBuffer();

    for (var i = 0; i < 9; i += 1) {
      buffer.write(Random().nextInt(9).toString());
    }
    numbers = buffer.toString();

    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();

    return useFormat ? format(numbers) : numbers;
  }
}
