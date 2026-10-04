class TokenErorrModel {
  String message;
  TokenErrorModelData? data;

  TokenErorrModel({required this.message, this.data});

  factory TokenErorrModel.formJson(Map<String, dynamic> json) {
    return TokenErorrModel(
      message: json["message"] ?? "",
      data: json["data"] != null
          ? TokenErrorModelData.formJson(json["data"])
          : null,
    );
  }
}

class TokenErrorModelData {
  List<String> phone;
  List<String> password;
  List<String> deviceName;
  List<String> name;
  List<String> currentPassword;
  List<String> passwordConfirmation;
  List<String> stampPrice;
  List<String> stampPauseHours;
  List<String> shift1Start;
  List<String> shift1End;
  List<String> shift2Start;
  List<String> shift2End;

  TokenErrorModelData({
    required this.phone,
    required this.password,
    required this.deviceName,
    required this.name,
    required this.currentPassword,
    required this.passwordConfirmation,
    required this.stampPrice,
    required this.stampPauseHours,
    required this.shift1Start,
    required this.shift1End,
    required this.shift2Start,
    required this.shift2End,
  });

  factory TokenErrorModelData.formJson(Map<String, dynamic> json) {
    return TokenErrorModelData(
      phone: List<String>.from(json["phone"] ?? []),
      password: List<String>.from(json["password"] ?? []),
      deviceName: List<String>.from(json["device_name"] ?? []),
      name: List<String>.from(json["name"] ?? []),
      currentPassword: List<String>.from(json["current_password"] ?? []),
      passwordConfirmation: List<String>.from(
        json["password_confirmation"] ?? [],
      ),
      stampPrice: List<String>.from(json["stamp_price"] ?? []),
      stampPauseHours: List<String>.from(json["stamp_pause_hours"] ?? []),
      shift1Start: List<String>.from(json["shift_1_start"] ?? []),
      shift1End: List<String>.from(json["shift_1_end"] ?? []),
      shift2Start: List<String>.from(json["shift_2_start"] ?? []),
      shift2End: List<String>.from(json["shift_2_end"] ?? []),
    );
  }
}
