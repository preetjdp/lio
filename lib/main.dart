import 'package:flutter/material.dart';
import 'package:lio/LoadingPage.dart';
import 'HomePage.dart';
import 'Tour.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lio',
      home: HomePage(),
    );
  }
}