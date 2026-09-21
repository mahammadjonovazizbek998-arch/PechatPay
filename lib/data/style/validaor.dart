class AppValidator {
  static String? password({String? value}) {
    if (value == null || value.isEmpty) {
      return "Parol maydoni bo'sh qolishi mumkin emas";
    } else if (value.length < 8) {
      return "Parol kamida 8 ta belgidan iborat bo'lishi kerak";
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Parolda kamida bitta katta harf bo'lishi kerak";
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Parolda kamida bitta kichik harf bo'lishi kerak";
    } else {
      return null;
    }
  }

  static String? phone({String? value}) {
    if (value == null || value.isEmpty) {
      return "Telfon raqamni  maydoni bo'sh qolishi mumkin emas";
    } else {
      if (value.length == 9 && !value.startsWith("+998")) {
        return null;
      } else if (value.length == 13 && value.startsWith("+998")) {
        return null;
      } else {
        return "Telfon raqamni  maydoni notug'ri tuldirilgan";
      }
    }
  }
}
