import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

//「通知を許可しますか」ってやつ↓
void main() async {
  //ranAppよりも前に何かしたい場合に追記するらしい
  WidgetsFlutterBinding.ensureInitialized();

//iOS設定
  final IOSInitializationSettings initializationSettingsIOS =
      // ignore: prefer_const_constructors
      IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  //initializationSettingsのオブジェクト作成
  final InitializationSettings initializationSettings = InitializationSettings(
    iOS: initializationSettingsIOS,
    android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  runApp(MyApp());
}

// 通知の表示部分のアイコンはアプリアイコン、名前はアプリ名が表示
void setNotification() async {
  const IOSNotificationDetails iOSPlatformChannelSpecifics =
      IOSNotificationDetails(
          sound:
              'example.mp3', //あとで通知音設定する（今はデフォルト）→https://note.com/y_yyyy/n/n1db10d4f2161
          presentAlert: true,
          presentBadge: true,
          presentSound: true);
  NotificationDetails platformChannelSpecifics = const NotificationDetails(
    iOS: iOSPlatformChannelSpecifics,
    android: null,
  );
  await flutterLocalNotificationsPlugin.show(
      0, '時計', 'タイマー', platformChannelSpecifics);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //デバッグ実行時の「DEBUG」表示を消す
      title: '浦田蒼海の初めてのアプリ開発',
      theme: ThemeData(primaryColor: Colors.white //AppBarの色ここで変えれるよ,
          ),
      home: HomeScreen(),
    );
  }
}
