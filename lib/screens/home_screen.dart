import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const initialSeconds = 3;
  static const initialPomodoros = 0;
  int totalSeconds = initialSeconds;
  int totalPomodoros = initialPomodoros;

  bool isRunning = false;
  bool isPause = true;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros += 1;
        isRunning = false;
        isPause = !isRunning;
        totalSeconds = initialSeconds;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
      isPause = !isRunning;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      isPause = !isRunning;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      isPause = !isRunning;
      totalSeconds = initialSeconds;
    });
  }

  void onPomodoroResetPressed() {
    setState(() {
      totalPomodoros = initialPomodoros;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          isRunning
              ? Flexible(
                  flex: 3,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: onPausePressed,
                        iconSize: 120,
                        color: Theme.of(context).cardColor,
                        icon: const Icon(Icons.pause),
                      ),
                    ],
                  )),
                )
              : Flexible(
                  flex: 3,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: isRunning ? onPausePressed : onStartPressed,
                        iconSize: 120,
                        color: Theme.of(context).cardColor,
                        icon: const Icon(
                          Icons.play_circle_outline,
                        ),
                      ),
                      IconButton(
                        onPressed: onResetPressed,
                        iconSize: 120,
                        color: Theme.of(context).cardColor,
                        icon: const Icon(
                          Icons.stop,
                        ),
                      ),
                    ],
                  )),
                ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Pomodoros",
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "$totalPomodoros",
                              style: TextStyle(
                                fontSize: 58,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            isPause
                                ? IconButton(
                                    onPressed: onPomodoroResetPressed,
                                    icon: const Icon(
                                      Icons.cancel,
                                    ),
                                  )
                                : Column()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
