import 'package:flutter/material.dart';
import 'home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Tutorial',
      theme: ThemeData(
          primaryColor: Colors.lightGreen,
          primaryColorDark: Colors.green,
          accentColor: Colors.yellowAccent),
      home: Home(),
    );
  }
}
