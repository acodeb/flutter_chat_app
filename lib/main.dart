import 'package:flutter/material.dart';
import './pages/login_page.dart';
import './pages/landing_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _title = 'VAbot App';
  LoginPage _login;
  _MyAppState() {
    _login = new LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: _title,
      routes: <String, WidgetBuilder> {
        '/landingpage': (BuildContext context) => new LandingPage(),
        '/login': (BuildContext context) => new MyApp(),
      },
      home: _login,
    );
  }
}