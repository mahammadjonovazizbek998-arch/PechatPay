import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:pechat_pay/logon/login/login_cubit.dart';

import '../get_it/get_it.dart';

class ApiService {
  final String url = "https://pechatpay.com/api";

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  Future<Map<String, String>> _headers({bool withAuth = false}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (withAuth) {
      final token = sl<LoginCubit>().state.token!.token;

      if (token != "") {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  // Helper for GET requests with logging
  Future<http.Response> _get(Uri uri, {bool withAuth = true}) async {
    final stopwatch = Stopwatch()..start();
    _logger.i("🌐 [GET REQUEST] ${uri.toString()}");
    try {
      final headers = await _headers(withAuth: withAuth);
      final response = await http.get(uri, headers: headers);
      stopwatch.stop();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _logger.d(
          "📥 [GET SUCCESS] ${uri.path}\n"
          "Status: ${response.statusCode} | ⏱ Vaqt: ${stopwatch.elapsedMilliseconds}ms\n"
          "Body: ${response.body}",
        );
      } else {
        _logger.w(
          "⚠️ [GET WARNING] ${uri.path}\n"
          "Status: ${response.statusCode} | ⏱ Vaqt: ${stopwatch.elapsedMilliseconds}ms\n"
          "Body: ${response.body}",
        );
      }
      return response;
    } catch (e) {
      stopwatch.stop();
      _logger.e(
        "❌ [GET ERROR] ${uri.path} | ⏱ Vaqt: ${stopwatch.elapsedMilliseconds}ms\nError: $e",
      );
      rethrow;
    }
  }

  // Helper for POST requests with logging
  Future<http.Response> _post(
    Uri uri, {
    Object? body,
    bool withAuth = true,
  }) async {
    final stopwatch = Stopwatch()..start();
    _logger.i("🌐 [POST REQUEST] ${uri.toString()}\nPayload: $body");
    try {
      final headers = await _headers(withAuth: withAuth);
      final response = await http.post(uri, headers: headers, body: body);
      stopwatch.stop();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _logger.d(
          "📥 [POST SUCCESS] ${uri.path}\n"
          "Status: ${response.statusCode} | ⏱ Vaqt: ${stopwatch.elapsedMilliseconds}ms\n"
          "Body: ${response.body}",
        );
      } else {
        _logger.w(
          "⚠️ [POST WARNING] ${uri.path}\n"
          "Status: ${response.statusCode} | ⏱ Vaqt: ${stopwatch.elapsedMilliseconds}ms\n"
          "Body: ${response.body}",
        );
      }
      return response;
    } catch (e) {
      stopwatch.stop();
      _logger.e(
        "❌ [POST ERROR] ${uri.path} | ⏱ Vaqt: ${stopwatch.elapsedMilliseconds}ms\nError: $e",
      );
      rethrow;
    }
  }

  //Sin In funksiya
  Future<http.Response> sinIn(
    String phone,
    String password,
    String androidInfo,
  ) async {
    final Uri uri = Uri.parse("$url/auth/login");
    return _post(
      uri,
      withAuth: false,
      body: jsonEncode({
        "phone": phone,
        "password": password,
        "device_name": androidInfo,
      }),
    );
  }

  //profil malumotlari
  Future<http.Response> authMe() async {
    final Uri uri = Uri.parse("$url/auth/me");
    return _get(uri, withAuth: true);
  }

  //itzimda chqish
  Future<http.Response> logout() async {
    final Uri uri = Uri.parse("$url/auth/logout");
    return _post(uri, withAuth: true);
  }

  Future<http.Response> meUpdate(
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
    final Uri uri = Uri.parse("$url/auth/me");
    final Map<String, dynamic> body = {
      "name": name,
      "phone": phone,
      "stamp_price": stampPrice,
      "stamp_pause_hours": stampPauseHurs,
      "shift_1_start": shift1Start,
      "shift_1_end": shift1End,
      "shift_2_start": shift2Start,
      "shift_2_end": shift2End,
      if (password.isNotEmpty) ...{
        "current_password": currentPassword,
        "password": password,
        "password_confirmation": passwordConfirmation,
      },
    };
    return _post(uri, withAuth: true, body: jsonEncode(body));
  }

  Future<http.Response> filiallPage() async {
    final Uri uri = Uri.parse("$url/store");
    return _get(uri, withAuth: true);
  }

  Future<http.Response> filiallUpdate(
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
    final Uri uri = Uri.parse(id != null ? "$url/store/$id" : "$url/store");
    final Map<String, dynamic> body = {
      "name": name,
      "phone": phone,
      "stamp_price": stampPrice,
      "stamp_pause_hours": stampPauseHurs,
      "shift_1_start": shift1Start,
      "shift_1_end": shift1End,
      "shift_2_start": shift2Start,
      "shift_2_end": shift2End,
      if (password.isNotEmpty) ...{
        if (currentPassword != null && currentPassword.isNotEmpty)
          "current_password": currentPassword,
        "password": password,
        "password_confirmation": passwordConfirmation,
      },
    };
    return _post(uri, withAuth: true, body: jsonEncode(body));
  }

  Future<http.Response> noActiveDriver(int day, int page) async {
    final Uri uri = Uri.parse("$url/drivers/noactive?page=$page");
    return _post(uri, withAuth: true, body: jsonEncode({"days": day}));
  }

  Future<http.Response> historyHomePage(int page) async {
    final Uri uri = Uri.parse("$url/drivers/recent-activity?page=$page");
    return _get(uri, withAuth: true);
  }

  Future<http.Response> searchHome(int page, String query) async {
    final Uri uri = Uri.parse("$url/drivers/search?page=$page");
    return _post(uri, withAuth: true, body: jsonEncode({"query": query}));
  }

  Future<http.Response> show(int id) async {
    final Uri uri = Uri.parse("$url/drivers/$id");
    return _get(uri, withAuth: true);
  }

  Future<http.Response> showHistory(int id, int page) async {
    final Uri uri = Uri.parse("$url/drivers/$id/history?page=$page");
    return _get(uri, withAuth: true);
  }

  Future<http.Response> pechat(String type, int id) async {
    final Uri uri = Uri.parse("$url/pechat/$id");
    return _post(uri, withAuth: true, body: jsonEncode({"type": type}));
  }

  Future<http.Response> pay(int id, int count) async {
    final Uri uri = Uri.parse("$url/pay/$id");
    return _post(
      uri,
      withAuth: true,
      body: jsonEncode({"count": count.toString()}),
    );
  }

  Future<http.Response> driverPage(
    String? search,
    String sort,
    List<String> filters,
    int page,
  ) async {
    final Uri uri = Uri.parse("$url/drivers/filters?page=$page");
    return _post(
      uri,
      withAuth: true,
      body: jsonEncode({"search": ?search, "sort": sort, "filters": filters}),
    );
  }

  Future<http.Response> createUpdateDriver(
    String name,
    String phone,
    String carNumer,
    int? id,
  ) async {
    final Uri uri = Uri.parse(
      id != null ? "$url/drivers/$id" : "$url/drivers/store",
    );
    return _post(
      uri,
      withAuth: true,
      body: jsonEncode({
        "name": name,
        "phone": phone,
        "car_number": carNumer
            .replaceAll(RegExp(r'[^A-Za-z0-9]'), '')
            .toUpperCase(),
      }),
    );
  }

  Future<http.Response> dashboard(
    int? id,
    String type,
    String? date,
    String? week_start,
    String? week_end,
    String? month,
    String? year,
  ) async {
    final Uri uri = Uri.parse("$url/dashboard");
    return _post(
      uri,
      withAuth: true,
      body: jsonEncode({
        "branch_id": id,
        "type": type,
        "date": date ?? "",
        "week_start": week_start ?? "",
        "week_end": week_end ?? "",
        "month": month ?? "",
        "year": year ?? "",
      }),
    );
  }
}
