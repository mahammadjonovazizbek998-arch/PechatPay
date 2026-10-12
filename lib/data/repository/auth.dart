
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../logon/login/login_cubit.dart';
import '../dashboar_model/all_dashboar_model.dart';
import '../driver_model/driver_noactive_model.dart';
import '../driver_model/history_home_page.dart';
import '../driver_model/pechat.dart';
import '../driver_model/show_history.dart';
import '../driver_model/show_model.dart';
import '../get_it/get_it.dart';
import '../theme_model/theme_model.dart';
import '../token_model/token_erorr_model.dart';
import '../token_model/token_model.dart';
import 'api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  static String c(String? t, [String d = '']) =>
      (t == null || t.isEmpty) ? d : (t.length >= 5 ? t.substring(0, 5) : t);

  static String fmt(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  static TimeOfDay p12(TimeOfDay t) =>
      TimeOfDay(hour: (t.hour + 12) % 24, minute: t.minute);

  static TimeOfDay parse(String? t, TimeOfDay d) {
    final p = c(t).split(':');
    final h = p.length == 2 ? int.tryParse(p[0]) : null;
    final m = p.length == 2 ? int.tryParse(p[1]) : null;
    return (h == null || m == null) ? d : TimeOfDay(hour: h, minute: m);
  }

  static bool unset(String? s, String? e) =>
      c(s).isEmpty || c(e).isEmpty || (c(s) == '00:00' && c(e) == '00:00');

  static String range(String? s, String? e) =>
      unset(s, e) ? '--:-- - --:--' : '${c(s)} - ${c(e)}';

  static String? nophone(String? p) =>
      p != null && p.length > 4 ? p.substring(4) : p;

  static String digits(String v) => v.replaceAll(RegExp(r'[\s,]'), '');

  static String formatPlate(String? plate) {
    final raw = (plate ?? '')
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
        .toUpperCase();
    if (raw.length <= 2) return raw;
    return '${raw.substring(0, 2)} ${raw.substring(2)}';
  }

  static String formatDate(DateTime date) {
    const months = [
      'yanvar',
      'fevral',
      'mart',
      'aprel',
      'may',
      'iyun',
      'iyul',
      'avgust',
      'sentabr',
      'oktabr',
      'noyabr',
      'dekabr',
    ];

    final now = DateTime.now();
    final hh = date.hour.toString().padLeft(2, '0');
    final mm = date.minute.toString().padLeft(2, '0');
    final time = '$hh:$mm';

    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(date.year, date.month, date.day);
    final diff = today.difference(day).inDays;

    if (diff == 0) return '$time Bugun';
    if (diff == 1) return '$time Kecha';

    final monthName = months[date.month - 1];

    if (date.year == now.year) {
      return '$time ${date.day} $monthName';
    }

    return '${date.day} $monthName ${date.year}';
  }

  static String formatUzbekPhone(String input) {
    String digits = input.replaceAll(RegExp(r'\D'), '');

    if (digits.length == 9) {
      digits = '998$digits';
    } else if (digits.length == 10 && digits.startsWith('8')) {
      digits = '998${digits.substring(1)}';
    }

    if (digits.length != 12 || !digits.startsWith('998')) {
      return input; // formatlab bo'lmadi
    }

    final code = digits.substring(0, 3);
    final op = digits.substring(3, 5);
    final p1 = digits.substring(5, 8);
    final p2 = digits.substring(8, 10);
    final p3 = digits.substring(10, 12);

    return '+$code $op $p1 $p2 $p3';
  }
  /// pechatTrend dagi pik elementning indexini list ko'rinishida qaytaradi.
  /// Natija doim bitta element yoki bo'sh list.
  static List<int> findPeakIndexes(
      List<PechatTrendItem> pechat,
      List<PaymentTrendItem> payment,
      ) {
    if (pechat.isEmpty) return [];

    // 1) pechatTrend dagi eng katta summa
    final maxSumma = pechat.map((e) => e.summa).reduce((a, b) => a > b ? a : b);

    // 2) shu summaga teng bo'lgan indexlar (tartib bilan)
    final topIndexes = <int>[
      for (int i = 0; i < pechat.length; i++)
        if (pechat[i].summa == maxSumma) i
    ];

    // Bitta bo'lsa, shuni qaytaramiz
    if (topIndexes.length == 1) return topIndexes;

    // 3) paymentTrend dagi shu label ning summasi (topilmasa 0)
    int paymentSumma(int i) {
      for (final p in payment) {
        if (p.label == pechat[i].label) return p.summa;
      }
      return 0;
    }

    // 4) payment bo'yicha eng kattasi; teng bo'lsa birinchi kelgani qoladi
    int bestIndex = topIndexes.first;
    int bestPayment = paymentSumma(bestIndex);

    for (final i in topIndexes.skip(1)) {
      final p = paymentSumma(i);
      if (p > bestPayment) {
        bestPayment = p;
        bestIndex = i;
      }
    }

    return [bestIndex];
  }
  /// paymentTrend dagi pik elementning indexini list ko'rinishida qaytaradi.
  /// Natija doim bitta element yoki bo'sh list.
  static List<int> findPaymentPeakIndexes(
      List<PaymentTrendItem> payment,
      List<PechatTrendItem> pechat,
      ) {
    if (payment.isEmpty) return [];

    // 1) paymentTrend dagi eng katta summa
    final maxSumma = payment.map((e) => e.summa).reduce((a, b) => a > b ? a : b);

    // 2) shu summaga teng bo'lgan indexlar (tartib bilan)
    final topIndexes = <int>[
      for (int i = 0; i < payment.length; i++)
        if (payment[i].summa == maxSumma) i
    ];

    // Bitta bo'lsa, shuni qaytaramiz
    if (topIndexes.length == 1) return topIndexes;

    // 3) pechatTrend dagi shu label ning summasi (topilmasa 0)
    int pechatSumma(int i) {
      for (final p in pechat) {
        if (p.label == payment[i].label) return p.summa;
      }
      return 0;
    }

    // 4) pechat bo'yicha eng kattasi; teng bo'lsa birinchi kelgani qoladi
    int bestIndex = topIndexes.first;
    int bestPechat = pechatSumma(bestIndex);

    for (final i in topIndexes.skip(1)) {
      final p = pechatSumma(i);
      if (p > bestPechat) {
        bestPechat = p;
        bestIndex = i;
      }
    }

    return [bestIndex];
  }
  static String formatUzbekCarNumber(String input) {
    final op = input.substring(2, 3);
    final p1 = input.substring(3, 6);
    final p2 = input.substring(6, 8);
    return "$op $p1 $p2";
  }

  Future<void> callNumber(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Telefon ilovasini ochib bo\'lmadi: $phone';
    }
  }

  static String formatSum(String input) {
    String digits = input.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return '';

    // boshidagi ortiqcha nollarni olib tashlash
    digits = digits.replaceFirst(RegExp(r'^0+(?=\d)'), '');

    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      final posFromEnd = digits.length - i;
      buffer.write(digits[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) {
        buffer.write(' ');
      }
    }

    return buffer.toString();
  }

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
      pragma(await androidData());

      return e;
    }
  }

  //profil malumotlari
  Future<dynamic> authMe() async {
    try {
      final response = await _apiService.authMe();
      final data = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final model = TokenModelApiUserModel.formJson(data["data"]["user"]);
        TokenModel tokenModel = TokenModel(
          id: model.id,
          name: model.name,
          phone: model.phone,
          token: sl<LoginCubit>().state.token!.token,
          role: model.role,
          shift1Start: model.shift1Start,
          shift1End: model.shift1End,
          shift2Start: model.shift2Start,
          shift2End: model.shift2End,
          stampPrice: model.stampPrice,
          stampPauseHours: model.stampPauseHours,
        );
        await tokenSetSharedPreferences(tokenModel);
        return tokenModel;
      } else if (response.statusCode == 401) {
        return 401;
      } else {
        return TokenErorrModel.formJson(data);
      }
    } catch (e) {
      return e;
    }
  }

  //  itzimda chqish
  Future<dynamic> logOut() async {
    try {
      final response = await _apiService.logout();
      if (response.statusCode == 200 || response.statusCode == 401) {
        return null;
      } else {
        final data = jsonDecode(response.body);
        return TokenErorrModel.formJson(data);
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> meUpdate(
      String name,
      String phone,
      String currentPassword,
      String password,
      String passwordConfirmation,
      String stampPrice,
      String stampPauseHurs,
      String shift1Start,
      String shift1End,
      String shift2Start,
      String shift2End,
      ) async {
    try {
      final response = await _apiService.meUpdate(
        name,
        await phoneData(phone),
        currentPassword,
        password,
        passwordConfirmation,
        stampPrice,
        stampPauseHurs,
        shift1Start,
        shift1End,
        shift2Start,
        shift2End,
      );

      return httpResponse(response, (data) {
        final model = TokenModelApiUserModel.formJson(data["data"]["user"]);
        return TokenModel(
          id: model.id,
          name: model.name,
          phone: model.phone,
          token: sl<LoginCubit>().state.token!.token,
          role: model.role,
          shift1Start: model.shift1Start,
          shift1End: model.shift1End,
          shift2Start: model.shift2Start,
          shift2End: model.shift2End,
          stampPrice: model.stampPrice,
          stampPauseHours: model.stampPauseHours,
        );
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }

  Future<dynamic> filiallPage() async {
    try {
      final response = await _apiService.filiallPage();
      return httpResponse(response, (data) {
        final List<dynamic> rawList = data["data"] ?? [];
        final List<TokenModelApiUserModel> list = rawList
            .map(
              (item) =>
              TokenModelApiUserModel.formJson(item as Map<String, dynamic>),
        )
            .toList();
        return list;
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }

  Future<dynamic> httpResponse<T>(
      http.Response response,
      T Function(Map<String, dynamic> data) fromJson,
      ) async {
    Map<String, dynamic> data = {};
    if (response.body.isNotEmpty) {
      try {
        data = jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        return TokenErorrModel(message: "Server javobini o'qib bo'lmadi");
      }
    }

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return fromJson(data);

      case 204:
        return fromJson({});

      case 401:
        sl<LoginCubit>().logOut();
        return TokenErorrModel.formJson(data);

      case 403:
        return TokenErorrModel.formJson(data);

      case 400:
      case 404:
      case 405:
      case 409:
      case 422:
        return TokenErorrModel.formJson(data);

      case 429:
        return TokenErorrModel.formJson(
          data.isNotEmpty
              ? data
              : {"message": "Juda ko'p so'rov yuborildi, biroz kuting"},
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return TokenErorrModel.formJson(
          data.isNotEmpty ? data : {"message": "Serverda xatolik yuz berdi"},
        );
      default:
        return TokenErorrModel.formJson(
          data.isNotEmpty
              ? data
              : {"message": "Noma'lum xatolik (${response.statusCode})"},
        );
    }
  }

  Future<dynamic> filiallUpdate(
      String name,
      String phone,
      String? currentPassword,
      String password,
      String passwordConfirmation,
      String stampPrice,
      String stampPauseHurs,
      String shift1Start,
      String shift1End,
      String shift2Start,
      String shift2End,
      int? id,
      ) async {
    try {
      final response = await _apiService.filiallUpdate(
        name,
        await phoneData(phone),
        currentPassword,
        password,
        passwordConfirmation,
        stampPrice,
        stampPauseHurs,
        shift1Start,
        shift1End,
        shift2Start,
        shift2End,
        id,
      );

      return httpResponse(response, (data) {
        final model = TokenModelApiUserModel.formJson(data["data"]);
        return TokenModel(
          id: model.id,
          name: model.name,
          phone: model.phone,
          token: sl<LoginCubit>().state.token!.token,
          role: model.role,
          shift1Start: model.shift1Start,
          shift1End: model.shift1End,
          shift2Start: model.shift2Start,
          shift2End: model.shift2End,
          stampPrice: model.stampPrice,
          stampPauseHours: model.stampPauseHours,
        );
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }

  Future<dynamic> noActiveDriver(int day, int page) async {
    try {
      final response = await _apiService.noActiveDriver(day, page);
      return httpResponse(response, (data) {
        final model = DriverNoactiveResponse.fromJson(data);
        return DriverNoactiveResponse(data: model.data, meta: model.meta);
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }

  Future<dynamic> historyHomePage(int page) async {
    try {
      final response = await _apiService.historyHomePage(page);
      return httpResponse(response, (data) {
        final model = HistoryHomePage.fromJson(data);
        return HistoryHomePage(data: model.data, meta: model.meta);
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }

  Future<dynamic> searchHome(int page, String query) async {
    try {
      final response = await _apiService.searchHome(page, query);
      return httpResponse(response, (data) {
        final model = DriverNoactiveResponse.fromJson(data);
        return DriverNoactiveResponse(data: model.data, meta: model.meta);
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }

  Future<dynamic> show(int id) async {
    try {
      final response = await _apiService.show(id);
      return httpResponse(response, (data) {
        final model = DriverDetailData.fromJson(data["data"]);
        return DriverDetailData(
          pechatSumma: model.pechatSumma,
          driver: model.driver,
          unpaidPechat: model.unpaidPechat,
        );
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }

  Future<dynamic> showHistory(int id, int page) async {
    try {
      final response = await _apiService.showHistory(id, page);
      return httpResponse(response, (data) {
        final model = DriverHistoryResponse.fromJson(data);
        return DriverHistoryResponse(data: model.data, meta: model.meta);
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }

  Future<dynamic> pechat(int id, String type) async {
    try {
      final response = await _apiService.pechat(type, id);
      return httpResponse(response, (data) {
        final model = PechatCreateResponse.fromJson(data);
        return PechatCreateResponse(message: model.message, data: model.data);
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }

  Future<dynamic> pay(int id, int count) async {
    try {
      final response = await _apiService.pay(id, count);
      return httpResponse(response, (data) {
        final model = PechatCreateResponse.fromJson(data);
        return PechatCreateResponse(message: model.message, data: model.data);
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }

  Future<dynamic> driversPage(
      String? search,
      String sort,
      List<String> filters,
      int page,
      ) async {
    try {
      final response = await _apiService.driverPage(
        search,
        sort,
        filters,
        page,
      );
      return httpResponse(response, (data) {
        final model = DriverNoactiveResponse.fromJson(data);
        return DriverNoactiveResponse(data: model.data, meta: model.meta);
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }

  Future<dynamic> createUpdateDriver(
      String name,
      String phone,
      String carNumer,
      int? id,
      ) async {
    try {
      final response = await _apiService.createUpdateDriver(
        name,
        await phoneData(phone),
        carNumer,
        id,
      );
      return httpResponse(response, (data) {
        final model = Driver.fromJson(data["data"]);
        return Driver(
          id: model.id,
          name: model.name,
          phone: model.phone,
          carNumber: model.carNumber,
          unpaidPechatsCount: model.unpaidPechatsCount,
          unpaidPechatsSum: model.unpaidPechatsSum,
          createdAt: model.createdAt,
          updatedAt: model.updatedAt,
        );
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }

  Future<dynamic> dashboard(
      int? id,
      String type,
      String data,
      String? weekStart,
      String? weekEnd,
      String? month,
      String? year,
      ) async {
    try {
      final response = await _apiService.dashboard(
        id,
        type,
        data,
        weekStart,
        weekEnd,
        month,
        year,
      );
      return httpResponse(response, (data) {
        final model = StatsResponse.fromJson(data);
        return StatsResponse(message: model.message, data: model.data);
      });
    } catch (e) {
      return TokenErorrModel(message: e.toString(), data: null);
    }
  }
}
