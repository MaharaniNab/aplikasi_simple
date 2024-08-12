import 'dart:convert';

import 'package:aplikasi_simple/home_page.dart';
import 'package:aplikasi_simple/register_page.dart';
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  login(BuildContext context) async {
    String url = 'http://192.168.0.101/sertifikasi_jmp/user/login.php';
    var response = await http.post(
      Uri.parse(url),
      body: {
        'username': controllerUsername.text,
        'password': controllerPassword.text,
      },
    );
    Map responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      DInfo.toastSuccess('Login Success');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      DInfo.toastError("Login Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm8x6tzNqYXTm64-ul2Sm7qQiwj_0oF9-mQg&s",
                width: 300 /
                    3, // Mengatur lebar gambar menjadi 1/3 dari sebelumnya
                height: 300 /
                    3, // Mengatur tinggi gambar menjadi 1/3 dari sebelumnya
                fit: BoxFit
                    .cover, // Agar gambar memenuhi area dan tetap proporsional
              ),
            ),
            DView.textTitle(
              'Login',
              color: Colors.black,
            ),
            DView.height(),
            TextField(
              controller: controllerUsername,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(FeatherIcons.logIn, size: 20.0),
                labelText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
            DView.height(),
            TextField(
              controller: controllerPassword,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(FeatherIcons.lock, size: 20.0),
                labelText: 'Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
            DView.height(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  login(context);
                },
                child: Text("Login"),
              ),
            ),
            DView.height(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Text("Register"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
