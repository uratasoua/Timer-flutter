import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AlarmHomeState();
}

// アラーム一覧画面
class _AlarmHomeState extends State<AlarmHome> {
  // アラームリストのデータ
  List alarmList = [];
  bool _isOn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: ListView.builder(
        itemCount: alarmList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: UniqueKey(),
            background: Container(
              padding: EdgeInsets.only(right: 40),
              alignment: Alignment.centerRight,
              color: Colors.redAccent,
              child: const Icon(
                Icons.delete,
                size: 40,
                color: Colors.white,
              ),
            ),
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('確認'),
                    content: const Text("削除します。よろしいですか？"),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop(true);
                            alarmList.removeAt(index);
                          },
                          child: const Text("削除")),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("キャンセル"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Column(
              children: <Widget>[
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Text(
                          alarmList[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 40,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 150.0),
                          //valueを変えないとonoffボタン全部反応しちゃうよ
                          child: CupertinoSwitch(
                            value: _isOn,
                            onChanged: (bool value) {
                              setState(() {
                                _isOn = value;
                              });
                            },
                            activeColor: CupertinoColors.activeGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  height: 110,
                  width: double.infinity,
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                  color: Color.fromARGB(255, 77, 77, 77),
                ),
              ],
            ),
            onDismissed: (direction) {
              // 削除時の処理
              setState(() {
                alarmList.remove;
              });
            },
          );
        },
      ),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        margin: EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 63, 63, 63),
          onPressed: () async {
            // "push"で新規画面に遷移
            // アラーム追加画面から渡される値を受け取る
            final newListText = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                //遷移先の画面としてアラーム追加画面を指定
                return AlarmNextAddPage();
              }),
            );
            if (newListText != null) {
              print(newListText);
              print("$newListText受け取った");
              setState(() {
                //アラームの追加
                alarmList.add(newListText);
              });
            }
          },
          child: const Icon(
            Icons.add,
            size: 45,
          ),
        ),
      ),
    );
  }
}

// プラスボタン押した後の処理 ⏬
class AlarmNextAddPage extends StatefulWidget {
  @override
  _AlarmNextAddPageState createState() => _AlarmNextAddPageState();
}

// アラーム追加画面用Widget
class _AlarmNextAddPageState extends State<AlarmNextAddPage> {
  //選択された時間ををデータとして持つ
  dynamic _text = "";
  //データをもとに表示するWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 63, 63),
        //色かえる
        title: const Text("アラーム追加画面"),
      ),
      backgroundColor: Color((0xFF2D2F41)),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: SizedBox(
                width: 285,
                height: 320,
                child: CupertinoTimerPicker(
                  alignment: Alignment.center,
                  mode: CupertinoTimerPickerMode.hm,
                  //値を受け取る（value）
                  onTimerDurationChanged: (value) {
                    //データが変更したことを知らせる（画面を更新する）
                    int hour = value.inHours;
                    int minute = value.inMinutes.remainder(60);
                    final show =
                        "${hour.toString().padLeft(2, " ")}:${minute.toString().padLeft(2, "0")}";
                    setState(() {
                      print("$_text前");
                      // データを変更
                      _text = show;
                      print("$_text後");
                    });
                  },
                ),
              ),
            ),
            Container(
              width: 180,
              height: 55,
              // アラーム追加ボタン
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 63, 63, 63),
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  //popの引数から最初の画面にデータを渡す
                  Navigator.of(context).pop(_text);
                },
                child: const Text(
                  'アラームを追加する',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: 140,
              height: 55,
              // キャンセルボタン
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'キャンセル',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
