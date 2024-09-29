import 'dart:async'; // Necessário para o Timer
import 'package:flutter/material.dart';

class PomodoroTimer extends StatefulWidget {
  PomodoroTimer(this.handleRestColors ,{super.key});
  final void Function(bool restState) handleRestColors; 

  @override
  State<PomodoroTimer> createState() => _TimerIncrementState();
}

class _TimerIncrementState extends State<PomodoroTimer> {

  int _seconds = 1495; 
  Timer? _timer;
  bool isPauseTime = false;
  bool hasReachedFocusingLimit = false;
  bool hasReachedPauseLimit = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (hasReachedFocusingLimit) {
      _seconds = 300;
      isPauseTime = true;
      widget.handleRestColors(true);
    } else if (hasReachedPauseLimit) {
      _seconds = 0;
      isPauseTime = false;
      widget.handleRestColors(false);
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  String getFormattedTime() {
    var minutes = _seconds ~/ 60;
    handleTimeLimit(minutes);
    var secondsOfMinute = _seconds % 60;
    return "${minutes < 10 ? "0$minutes" : minutes}:${secondsOfMinute < 10 ? "0$secondsOfMinute" : secondsOfMinute}";
  }

  void handleTimeLimit (int minutes) {
    hasReachedFocusingLimit = minutes == 25 && !isPauseTime;
    hasReachedPauseLimit = minutes == 5 && isPauseTime;

    if(hasReachedFocusingLimit || hasReachedPauseLimit) {
      _timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(getFormattedTime(), style: const TextStyle(fontSize: 24)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: hasReachedFocusingLimit || hasReachedFocusingLimit ? 0.3 : 1,
                child: IconButton(
                onPressed: () {
                  if(!hasReachedFocusingLimit || !hasReachedFocusingLimit) {
                    _timer?.cancel();
                  }
                },
                icon: const Icon(Icons.pause),
              ),),
              Opacity(
                opacity: _timer?.isActive == true ? 0.3 : 1,
                child: IconButton(
                onPressed: () {
                  if(_timer?.isActive == false) {
                    _startTimer();
                  }
                },
                icon: const Icon(Icons.play_arrow_outlined),
              ),),
            ],
          ),
        ],
      ),
    );
  }
}

