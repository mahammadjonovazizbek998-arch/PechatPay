class ThemeModel {
  bool theme;

  ThemeModel({required this.theme});

  factory ThemeModel.formJson(Map<String, dynamic> json) {
    return ThemeModel(theme: json["theme"] ?? true);
  }

  Map<String, dynamic> toMap() {
    return {"theme": theme};
  }
}
