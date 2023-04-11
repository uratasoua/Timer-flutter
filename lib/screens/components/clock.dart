import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'clock_painter.dart';

//↓時計の形を作るコード↓

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        return;
      }
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF3A3D50),
            shape: BoxShape.circle,
            //↓時計の影
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                color: Colors.white,
                blurRadius: 64,
              )
            ],
          ),
          child: Transform.rotate(
            angle: -pi / 2,
            child: CustomPaint(
              painter: ClockPainter(context, _dateTime),
            ),
          ),
        ),
      ),
    );
  }
}
