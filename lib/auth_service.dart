import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'http://192.168.0.101/sertifikasi_jmp/user/';

  static Future<Map> login(String username, String password) async {
    String url = '${_baseUrl}login.php';
    var response = await http.post(Uri.parse(url), body: {
      'username': username,
      'password': password,
    });
    return jsonDecode(response.body);
  }

  static Future<Map> register(String username, String password) async {
    String url = '${_baseUrl}register.php';
    var response = await http.post(Uri.parse(url), body: {
      'username': username,
      'password': password,
    });
    return jsonDecode(response.body);
  }
}
