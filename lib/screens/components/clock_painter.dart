import 'dart:math';
import 'package:flutter/material.dart';

//↓時計の針のコード↓

class ClockPainter extends CustomPainter {
  final BuildContext context;
  final DateTime dateTime;

  ClockPainter(this.context, this.dateTime);
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.width / 2;
    Offset center = Offset(centerX, centerY);

    //時間を受け取る
    double hourX = centerX +
        size.width *
            0.3 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    double hourY = centerY +
        size.width *
            0.3 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    //時間の棒
    canvas.drawLine(
        center,
        Offset(hourX, hourY),
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 9);
    //分を受け取る
    double minX =
        centerX + size.width * 0.35 * cos((dateTime.minute * 6) * pi / 180);
    double minY =
        centerY + size.width * 0.35 * sin((dateTime.minute * 6) * pi / 180);
    //分の棒
    canvas.drawLine(
        center,
        Offset(minX, minY),
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 7);

    //秒を受け取る
    double secondX =
        centerX + size.width * 0.4 * cos((dateTime.second * 6) * pi / 180);
    double secondY =
        centerY + size.width * 0.4 * sin((dateTime.second * 6) * pi / 180);
    //秒の棒
    canvas.drawLine(center, Offset(secondX, secondY),
        Paint()
          ..color = const Color(0xFFFF0000)
          ..strokeWidth = 2);

    //センターサークルです
    canvas.drawCircle(center, 10, Paint()..color = Colors.grey);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
