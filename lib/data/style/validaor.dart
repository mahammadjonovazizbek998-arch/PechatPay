class AppValidator {
  static String? password({
    String? value,
    required String name,
    String? newPassword,
  }) {
    if (value == null || value.isEmpty) {
      return "$name maydoni bo'sh qolishi mumkin emas";
    } else if (value.length < 8) {
      return "$name kamida 8 ta belgidan iborat bo'lishi kerak";
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "$name kamida bitta katta harf bo'lishi kerak";
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "$name kamida bitta kichik harf bo'lishi kerak";
    } else if (value != newPassword && newPassword != null) {
      return "Parollar mos kelmadi";
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

  static String? branchName({String? value}) {
    if (value == null || value.isEmpty) {
      return "Filial nomi maydoni bo'sh qolishi mumkin emas";
    } else {
      if (value.length >= 7 && value.length < 255) {
        return null;
      } else {
        return "Filial nomi maydoni notug'ri tuldirilgan";
      }
    }
  }

  static String? summa({String? value}) {
    if (value == null || value.isEmpty) {
      return "Pecha stavkasi maydoni bo'sh qolishi mumkin emas";
    } else {
      if (value.length >= 4 && value.length < 20) {
        return null;
      } else {
        return "Pecha stavkasi maydoni notug'ri tuldirilgan";
      }
    }
  }
}
