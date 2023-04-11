import 'package:flutter/material.dart';
import 'package:timer/screens/components/body.dart';
import 'package:timer/timers/countdown.dart';
import '../alarms/alarm_home.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> pageList = [Clock(), Alarm(), Timer()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: buildAppBar(context),
        body: IndexedStack(
          index: selectedIndex,
          children: pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          //ここから下がフッター
          backgroundColor: const Color(0xFF2D2F41),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.query_builder), label: '時計'),
            BottomNavigationBarItem(icon: Icon(Icons.alarm_add), label: 'アラーム'),
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'タイマー'),
          ],
          currentIndex: selectedIndex,
          onTap: (int index) {
            if (!mounted) {
              return;
            }
              setState(() {
                selectedIndex = index;
              });
          },
          selectedItemColor: Colors.white, //フッターの選択されているボタンの色
          unselectedItemColor: Colors.grey, //選択されていないボタンの色
        ),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: const Color(0xFF2D2F41), //appbarの色
    leading: const OverflowBox(),
    actions: <Widget>[
      TextButton.icon(
        //ボタンの種類を変えたい
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(Colors.white), //設定アイコンと文字
        ),
        onPressed: () {
          //ボタンが押されたときの動作をここに書く
        },
        icon: const Icon(Icons.settings),
        label: const Text('設定'),
      )
    ],
  );
}

//↓フッターを押した時の反応↓

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Alarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlarmHome(),
    );
  }
}


class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CountdownPage(),
    );
  }
}
