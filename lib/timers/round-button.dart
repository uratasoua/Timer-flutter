import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
      ),
      child: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 63, 63, 63),
        radius: 40, //アイコンを丸くする
        child: Icon(
          icon,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
