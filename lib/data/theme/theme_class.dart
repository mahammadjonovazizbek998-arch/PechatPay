import 'package:flutter/material.dart';

class ThemeClass extends ThemeExtension<ThemeClass> {
  final Color globalBackgroundColor,
      globalColor,
      textColor,
      unselctedColor,
      text,
      cardColor,
      container,
      unselctedCardColor,
      logUot,
      phonColor,
      shiftColor,
      rejectionStampDialog;

  ThemeClass({
    required this.globalBackgroundColor,
    required this.globalColor,
    required this.textColor,
    required this.unselctedColor,
    required this.text,
    required this.cardColor,
    required this.container,
    required this.unselctedCardColor,
    required this.logUot,
    required this.phonColor,
    required this.shiftColor,
    required this.rejectionStampDialog,
  });

  @override
  ThemeExtension<ThemeClass> copyWith() {
    return ThemeClass(
      globalBackgroundColor: globalBackgroundColor,
      globalColor: globalColor,
      textColor: textColor,
      unselctedColor: unselctedColor,
      text: text,
      cardColor: cardColor,
      container: container,
      unselctedCardColor: unselctedCardColor,
      logUot: logUot,
      phonColor: phonColor,
      shiftColor: shiftColor,
      rejectionStampDialog: rejectionStampDialog,
    );
  }

  @override
  ThemeExtension<ThemeClass> lerp(
    covariant ThemeExtension<ThemeClass>? other,
    double t,
  ) {
    if (other is! ThemeClass) return this;
    return ThemeClass(
      globalBackgroundColor: Color.lerp(
        globalBackgroundColor,
        globalBackgroundColor,
        t,
      )!,
      globalColor: Color.lerp(globalColor, globalColor, t)!,
      textColor: Color.lerp(textColor, textColor, t)!,
      unselctedColor: Color.lerp(unselctedColor, unselctedColor, t)!,
      text: Color.lerp(text, text, t)!,
      cardColor: Color.lerp(cardColor, cardColor, t)!,
      container: Color.lerp(container, container, t)!,
      unselctedCardColor: Color.lerp(
        unselctedCardColor,
        unselctedCardColor,
        t,
      )!,
      logUot: Color.lerp(logUot, logUot, t)!,
      phonColor: Color.lerp(phonColor, phonColor, t)!,
      shiftColor: Color.lerp(shiftColor, shiftColor, t)!,
      rejectionStampDialog: Color.lerp(
        rejectionStampDialog,
        rejectionStampDialog,
        t,
      )!,
    );
  }
}

final ThemeClass lightCustom = ThemeClass(
  globalBackgroundColor: const Color(0xFFF1F1F1),
  globalColor: const Color(0xFF104DE8),
  textColor: const Color(0xFFFFFFFF),
  unselctedColor: Colors.grey,
  text: const Color(0xFF3D3D3D),
  cardColor: const Color(0xFFFFFFFF),
  container: const Color(0x1A104DE8),
  unselctedCardColor: const Color(0xFFF3F3F3),
  logUot: Color(0xFF93000A),
  phonColor: Color(0xFF059669),
  shiftColor: Color(0xFF92400E),
  rejectionStampDialog:Color(0xFFD97706),
);
final ThemeClass darkCustom = ThemeClass(
  globalBackgroundColor: const Color(0xFF0F172A),
  globalColor: const Color(0xFF104DE8),
  textColor: const Color(0xFFFFFFFF),
  unselctedColor: Colors.black54,
  text: const Color(0xFF232020),
  cardColor: const Color(0xFFE2E8F0),
  container: const Color(0xFFFFFFFF),
  unselctedCardColor: const Color(0xFFF3F3F3),
  logUot: Color(0xFF93000A),
  phonColor: Color(0xFF059669),
  shiftColor: Color(0xFF92400E),
  rejectionStampDialog: Color(0xFFD2691E),
);
