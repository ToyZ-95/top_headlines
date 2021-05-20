import 'package:flutter/material.dart';
import 'package:news_app/pages/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //In new branch
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      home: HomePage(),
    );
  }
}
