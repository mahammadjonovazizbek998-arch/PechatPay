import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String url = "https://pechatpay.com/api";

  Map<String, String> _headers(String? token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
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
      headers: _headers(null),
      body: jsonEncode({
        "phone": phone,
        "password": password,
        "device_name": androidInfo,
      }),
    );
  }

  //profil malumotlari
  Future<http.Response> authMe(String token) async {
    final Uri uri = Uri.parse("$url/auth/me");
    return http.get(uri, headers:  _headers(token));
  }

  // //itzimda chqish
  // Future<http.Response> logout(String token) async {
  //   final Uri uri = Uri.parse("$url/auth/logout");
  //   return http.post(uri, headers: await _headers(token));
  // }
}
