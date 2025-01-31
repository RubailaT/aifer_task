import 'package:aifer_task/provider/quiz_provider.dart';
// import 'package:aifer_task/screens/quiz_app_screen.dart';
import 'package:aifer_task/screens/quiz_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (_) => QuizProvider(),
        child: QuizAppScreen(),
      ),
    );
  }
}
