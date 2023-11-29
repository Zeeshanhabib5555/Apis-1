import 'package:apis_start_1/post_home_screen.dart';
import 'package:apis_start_1/ruku_model_screen.dart';
import 'package:apis_start_1/ruku_model_screen_2.dart';
import 'package:apis_start_1/user_model_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: RukuModelScreen2(),
    );
  }
}