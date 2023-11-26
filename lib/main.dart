import 'package:bookabuku/pages/login_pages.dart';
import 'package:bookabuku/pages/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        WelcomePage.id: (context) => WelcomePage(),
      },
    );
  }
}
