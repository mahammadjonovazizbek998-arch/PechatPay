part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {
  final bool? theme;

  const ThemeState({this.theme});
}

final class ThemeInitial extends ThemeState {}

final class ThemeFinish extends ThemeState {
  const ThemeFinish({required super.theme});
}

final class ThemeLoding extends ThemeState {
  const ThemeLoding({ required super.theme});
}
