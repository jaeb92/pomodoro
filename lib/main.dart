import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color.fromARGB(255, 24, 68, 19),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Color(0XFF232B55),
          ),
        ),
        cardColor: const Color(0XFFF4EDDB),
      ),
      home: const HomeScreen(),
    );
  }
}
