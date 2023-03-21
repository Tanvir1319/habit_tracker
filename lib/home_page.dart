import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_tracker/utilitis/habot_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List habitList = [
    //habitNamee,habitStarted,timeSpent(sec),timeGoal(min)
    ['Excercise', false, 0, 2],
    ['Read', false, 0, 20],
    ['Write', false, 0, 30],
    ['Code', false, 0, 40],
  ];

  void habitStarted(int index) {
    //note what the start time is
    var startTime = DateTime.now();

    //include the the time already elapsed

    int elapsedTime = habitList[index][2];

    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    if (habitList[index][1]) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (habitList[index][1] == false) {
            timer.cancel();
          }

          var currentTime = DateTime.now();
          habitList[index][2] = elapsedTime+currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void settingsOpened(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Settings For ' + habitList[index][0]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('demo'),
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: ((context, index) {
          return HabitTile(
            SettingsTapped: () {
              settingsOpened(index);
            },
            habitName: habitList[index][0],
            habitStarted: habitList[index][1],
            onTap: () {
              habitStarted(index);
            },
            timeGoal: habitList[index][3],
            timeSpent: habitList[index][2],
          );
        }),
      ),
    );
  }
}
