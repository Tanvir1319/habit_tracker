import 'package:flutter/material.dart';
import 'package:habit_tracker/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit-tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:HomePage() ,
    );
  }
}

