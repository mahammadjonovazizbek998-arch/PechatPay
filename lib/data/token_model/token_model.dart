class TokenModel {
  int id;
  String name;
  String phone;
  String token;

  TokenModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.token,
  });

  factory TokenModel.formjson(Map<String, dynamic> json) {
    return TokenModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      token: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "phone": phone, "token": token};
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

  TokenModelApiUserModel({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory TokenModelApiUserModel.formJson(Map<String, dynamic> json) {
    return TokenModelApiUserModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
    );
  }
}
