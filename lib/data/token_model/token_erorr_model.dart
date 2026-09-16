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

  TokenErrorModelData({
    required this.phone,
    required this.password,
    required this.deviceName,
  });

  factory TokenErrorModelData.formJson(Map<String, dynamic> json) {
    return TokenErrorModelData(
      phone: List<String>.from(json["phone"] ?? []),
      password: List<String>.from(json["password"] ?? []),
      deviceName: List<String>.from(json["device_name"] ?? []),
    );
  }
}
