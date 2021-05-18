import 'package:flutter/material.dart';
import 'package:news_app/pages/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: HomePage(),
    );
  }
}
