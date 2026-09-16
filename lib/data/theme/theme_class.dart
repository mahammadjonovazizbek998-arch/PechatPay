import 'package:flutter/material.dart';

class ThemeClass extends ThemeExtension<ThemeClass> {
  final Color globalBackgroundColor,
      globalColor,
      textColor,
      unselctedColor,
      text,
      cardColor;

  ThemeClass({
    required this.globalBackgroundColor,
    required this.globalColor,
    required this.textColor,
    required this.unselctedColor,
    required this.text,
    required this.cardColor,
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
    );
  }
}

final ThemeClass lightCustom = ThemeClass(
  globalBackgroundColor: const Color(0xFFF1F1F1),
  globalColor: const Color(0xFF104DE8),
  textColor: const Color(0xFFFFFFFF),
  unselctedColor: Colors.grey,
  text: const Color(0xFF232020),
  cardColor: const Color(0xFFFFFFFF),
);
final ThemeClass darkCustom = ThemeClass(
  globalBackgroundColor: const Color(0xFF0F172A),
  globalColor: const Color(0xFF104DE8),
  textColor: const Color(0xFFFFFFFF),
  unselctedColor: Colors.black54,
  text: const Color(0xFF232020),
  cardColor: const Color(0xFFE2E8F0),
);
