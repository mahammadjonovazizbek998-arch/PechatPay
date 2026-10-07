import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pechat_pay/logon/login/login_cubit.dart';

import '../get_it/get_it.dart';

class ApiService {
  final String url = "https://pechatpay.com/api";

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

  //Sin In funksiya
  Future<http.Response> sinIn(
    String phone,
    String password,
    String androidInfo,
  ) async {
    final Uri uri = Uri.parse("$url/auth/login");

    return http.post(
      uri,
      headers: await _headers(withAuth: false),
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
    return http.get(uri, headers: await _headers(withAuth: true));
  }

  //itzimda chqish
  Future<http.Response> logout() async {
    final Uri uri = Uri.parse("$url/auth/logout");
    return http.post(uri, headers: await _headers(withAuth: true));
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
    return http.post(
      uri,
      headers: await _headers(withAuth: true),
      body: jsonEncode({
        "name": name,
        "phone": phone,
        "current_password": currentPassword,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "stamp_price": stampPrice,
        "stamp_pause_hours": stampPauseHurs,
        "shift_1_start": shift1Start,
        "shift_1_end": shift1End,
        "shift_2_start": shift2Start,
        "shift_2_end": shift2End,
      }),
    );
  }

  Future<http.Response> filiallPage() async {
    final Uri uri = Uri.parse("$url/store");
    return http.get(uri, headers: await _headers(withAuth: true));
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
    return http.post(
      uri,
      headers: await _headers(withAuth: true),
      body: jsonEncode({
        "name": name,
        "phone": phone,
        if (id != null) "current_password": currentPassword,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "stamp_price": stampPrice,
        "stamp_pause_hours": stampPauseHurs,
        "shift_1_start": shift1Start,
        "shift_1_end": shift1End,
        "shift_2_start": shift2Start,
        "shift_2_end": shift2End,
      }),
    );
  }

  Future<http.Response> noActiveDriver(int day, int page) async {
    final Uri uri = Uri.parse("$url/drivers/noactive?page=$page");
    return http.post(
      uri,
      headers: await _headers(withAuth: true),
      body: jsonEncode({"days": day}),
    );
  }

  Future<http.Response> historyHomePage(int page) async {
    final Uri uri = Uri.parse("$url/drivers/recent-activity?page=$page");

    return await http.get(uri, headers: await _headers(withAuth: true));
  }

  Future<http.Response> searchHome(int page, String query) async {
    final Uri uri = Uri.parse("$url/drivers/search?page=$page");
    return await http.post(
      uri,
      headers: await _headers(withAuth: true),
      body: jsonEncode({"query": query}),
    );
  }

  Future<http.Response> show(int id) async {
    final Uri uri = Uri.parse("$url/drivers/$id");
    return await http.get(uri, headers: await _headers(withAuth: true));
  }

  Future<http.Response> showHistory(int id, int page) async {
    final Uri uri = Uri.parse("$url/drivers/$id/history?page=$page");
    return await http.get(uri, headers: await _headers(withAuth: true));
  }

  Future<http.Response> pechat(String type, int id) async {
    final Uri uri = Uri.parse("$url/pechat/$id");
    return await http.post(
      uri,
      headers: await _headers(withAuth: true),
      body: jsonEncode({"type": type}),
    );
  }

  Future<http.Response> pay(int id, int count) async {
    final Uri uri = Uri.parse("$url/pay/$id");
    return await http.post(
      uri,
      headers: await _headers(withAuth: true),
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
    return await http.post(
      uri,
      headers: await _headers(withAuth: true),
      body: jsonEncode({
        "search": ?search,
        "sort": sort,
        "filters": filters,
      }),
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
    return await http.post(
      uri,
      headers: await _headers(withAuth: true),
      body: jsonEncode({"name": name, "phone": phone, "car_number": carNumer.replaceAll(RegExp(r'[^A-Za-z0-9]'), '')
          .toUpperCase()}),
    );
  }
}
