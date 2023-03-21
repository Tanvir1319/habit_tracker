import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback SettingsTapped;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;

  const HabitTile({
    Key? key,
    required this.SettingsTapped,
    required this.habitName,
    required this.habitStarted,
    required this.onTap,
    required this.timeGoal,
    required this.timeSpent,
  }) : super(key: key);

  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(6);

    if (secs.length == 1) {
      secs = '0' + secs;
    }

    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }
    return mins + ':' + secs;
  }

  double percentCompleted() {
    return timeSpent / (timeGoal*60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 19.0, right: 19, top: 19),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        CircularPercentIndicator(
                          radius: 30,
                          percent: percentCompleted() <1 ? percentCompleted() :1,
                          progressColor: percentCompleted() > 0.5 ? (percentCompleted()>0.75 ? Colors.green: Colors.orange):Colors.red,
                          
                        ),
                        //play button
                        Center(
                          child: Icon(
                              habitStarted ? Icons.pause : Icons.play_arrow),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //habit name
                    Text(
                      habitName,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //progress
                    Text(
                      formatToMinSec(timeSpent) + '/' + timeGoal.toString()+ '=' + (percentCompleted()*100).toStringAsFixed(0) + '%' ,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(onTap: SettingsTapped, child: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
