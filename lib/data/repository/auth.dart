import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:pechat_pay/data/token_model/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme_model/theme_model.dart';
import '../token_model/token_erorr_model.dart';
import 'api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  // theme xotirga yozish
  Future<String?> setSharedPreferences(ThemeModel themeModel) async {
    try {
      final preference = await SharedPreferences.getInstance();

      await preference.setBool("theme", themeModel.theme);
      return "Finish";
    } catch (e) {
      return null;
    }
  }

  // theme xotirdan o'qish
  Future<ThemeModel> getSharePreferences() async {
    try {
      final preference = await SharedPreferences.getInstance();
      bool? themeString = preference.getBool("theme");
      if (themeString == null) {
        return ThemeModel(theme: true);
      } else {
        return ThemeModel(theme: themeString);
      }
    } catch (e) {
      return ThemeModel(theme: true);
    }
  }

  // token xotirga yozish
  Future<bool> tokenSetSharedPreferences(TokenModel? tokenModel) async {
    try {
      final preference = await SharedPreferences.getInstance();
      if (tokenModel != null) {
        String json = jsonEncode(tokenModel.toMap());
        await preference.setString("token", json);
      } else {
        await preference.remove("token");
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  //token xotridan o'qish
  Future<TokenModel?> tokenGetSharePreferences() async {
    try {
      final preference = await SharedPreferences.getInstance();
      String? tokenString = preference.getString("token");
      if (tokenString == null) {
        return null;
      } else {
        Map<String, dynamic> toMap = jsonDecode(tokenString);
        final tokenModelApi = TokenModel.formjson(toMap);
        return tokenModelApi;
      }
    } catch (e) {
      return null;
    }
  }

  //qurulma nomini oladi
  Future<String> androidData() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.model;
  }

  //telfon raqanga tuliq ishlov berish
  Future<String> phoneData(String phone) async {
    if (phone.startsWith("+998")) {
      return phone;
    } else {
      return "+998$phone";
    }
  }

  //ro'yxatdan o'tish
  Future<dynamic> sinIn(String phone, String password) async {
    try {
      final response = await _apiService.sinIn(
        await phoneData(phone),
        password,
        await androidData(),
      );
      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return TokenModelApi.formJson(data["data"]);
      } else {
        return TokenErorrModel.formJson(data);
      }
    } catch (e) {
      return e;
    }
  }

  //profil malumotlari
  Future<dynamic> authMe(String? tokeState) async {
    try {
      if (tokeState != null) {
        final response = await _apiService.authMe(tokeState);
        final data = jsonDecode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          final model = TokenModelApiUserModel.formJson(data["data"]["user"]);
          TokenModel tokenModel = TokenModel(
            id: model.id,
            name: model.name,
            phone: model.phone,
            token: tokeState,
          );
          await tokenSetSharedPreferences(tokenModel);
          return tokenModel;
        } else if (response.statusCode==401) {
          return 401;
        }
        else {
          return TokenErorrModel.formJson(data);
        }
      }
    } catch (e) {
      return e;
    }
  }

//itzimda chqish
// Future<dynamic> logOut() async {
//   try {
//     if (tokeState != null) {
//       print("salom");
//       final response = await _apiService.logout(tokeState!);
//       print("salom ${response.statusCode}");
//       if (response.statusCode >= 200 && response.statusCode <= 300 && response.statusCode==401) {
//         await tokenSetSharedPreferences(null);
//       } else {
//         final data = jsonDecode(response.body);
//         return TokenErorrModel.formJson(data);
//       }
//     }
//   } catch (e) {
//     return e;
//   }
// }
}
