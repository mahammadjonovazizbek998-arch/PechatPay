class TokenModel {
  int id;
  String name;
  String phone;
  String token;
  String role;
  String shift1Start;
  String shift1End;
  String shift2Start;
  String shift2End;
 int stampPrice;
  int stampPauseHours;

  TokenModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.token,
    required this.role,
    required this.shift1Start,
    required this.shift1End,
    required this.shift2Start,
    required this.shift2End,
    required this.stampPrice,
    required this.stampPauseHours,
  });

  factory TokenModel.formjson(Map<String, dynamic> json) {
    return TokenModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      token: json["token"] ?? "",
      role: json["role"] ?? "",
      shift1Start: json["shift_1_start"] ?? "",
      shift1End: json["shift_1_end"] ?? "",
      shift2Start: json["shift_2_start"] ?? "",
      shift2End: json["shift_2_end"] ?? "",
      stampPrice: json["stamp_price"] ?? 0,
      stampPauseHours: json["stamp_pause_hours"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "token": token,
      "role": role,
      "shift_1_start": shift1Start,
      "shift_1_end": shift1End,
      "shift_2_start": shift2Start,
      "shift_2_end": shift2End,
      "stamp_price": stampPrice,
      "stamp_pause_hours": stampPauseHours,
    };
  }
}

class TokenModelApi {
  String token;
  TokenModelApiUserModel? tokenModelApiUserModel;

  TokenModelApi({required this.token, this.tokenModelApiUserModel});

  factory TokenModelApi.formJson(Map<String, dynamic> json) {
    return TokenModelApi(
      token: json["token"] ?? "",
      tokenModelApiUserModel: json["user"] != null
          ? TokenModelApiUserModel.formJson(json["user"])
          : null,
    );
  }
}

class TokenModelApiUserModel {
  int id;
  String name;
  String phone;
  String role;
  String shift1Start;
  String shift1End;
  String shift2Start;
  String shift2End;
  int stampPrice;
  int stampPauseHours;

  TokenModelApiUserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    required this.shift1Start,
    required this.shift1End,
    required this.shift2Start,
    required this.shift2End,
    required this.stampPrice,
    required this.stampPauseHours,
  });

  factory TokenModelApiUserModel.formJson(Map<String, dynamic> json) {
    return TokenModelApiUserModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      role: json["role"] ?? "",
      shift1Start: json["shift_1_start"] ?? "",
      shift1End: json["shift_1_end"] ?? "",
      shift2Start: json["shift_2_start"] ?? "",
      shift2End: json["shift_2_end"] ?? "",
      stampPrice: json["stamp_price"] ?? 0,
      stampPauseHours: json["stamp_pause_hours"] ?? 0,
    );
  }
}
