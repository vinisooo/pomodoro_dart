import 'package:flutter/material.dart';
import 'package:pomodoro_timer/timer.dart';

class Pomodorus extends StatefulWidget {
  Pomodorus({super.key});
  @override
  State<Pomodorus> createState() => _PomodorusState();
}

class _PomodorusState extends State<Pomodorus> {
  bool restBackground = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: restBackground ? Colors.green[200] : Colors.white, // Simplified condition
      ),
      child: Center(
        child: PomodoroTimer((bool isRestTime) {
          setState(() { // Call setState to update the UI
            restBackground = isRestTime;
          });
        }),
      ),
    );
  }
}
