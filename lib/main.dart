import 'package:flutter/material.dart';
import './pages/login_page.dart';
import './pages/landing_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final String _title = 'VAbot App';

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: _title,
      routes: <String, WidgetBuilder> {
        '/landingpage': (BuildContext context) => new LandingPage(),
        '/login': (BuildContext context) => new MyApp(),
      },
      home: new LoginPage(),
    );
  }
}