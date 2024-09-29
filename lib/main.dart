import 'package:flutter/material.dart';
import 'package:pomodoro_timer/pomodorus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(home: Scaffold(body: Pomodorus()));
  }
}
