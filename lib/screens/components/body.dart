import 'package:flutter/material.dart';
import 'clock.dart';
import 'time_in_hour_and_minute.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: const Color(0xFF2D2F41), //背景の色
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const Text(
                  '日本の時間',
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 223, 222, 222)),
                ),
                const TimeInHourAndMinute(),
                Clock()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
