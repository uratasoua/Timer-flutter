import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:timer/timers/round-button.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  void notify() {
    if (countText == '0:00:00') {
      FlutterRingtonePlayer.play(
        android: AndroidSounds.notification,
        ios: const IosSound(1010),
      ); //音を鳴らす
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              //タイマーの周りの丸い円
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 295,
                  height: 295,
                  child: Theme(
                    data: ThemeData(primarySwatch: Colors.lightBlue),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey.shade200,
                      value: progress,
                      strokeWidth: 10,
                    ),
                  ),
                ),
                //時間のところを押した時の反応
                GestureDetector(
                  //GestureDetectorは押した時に何かしらの動作をさせたい時に使う
                  onTap: () {
                    //if文でカウントダウンが実行されていない時のみタイムピッカーが表示される設定にしている
                    if (controller.isDismissed) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          height: 300,
                          //タイムピッカー↓
                          child: CupertinoTimerPicker(
                            initialTimerDuration: controller.duration!,
                            onTimerDurationChanged: (time) {
                              setState(() {
                                controller.duration = time;
                              });
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) => Text(
                      countText,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 223, 222, 222),
                        fontSize: 60,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (controller.isAnimating) {
                    controller.stop();
                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    controller.reverse(
                        from: controller.value == 0 ? 1.0 : controller.value);
                    setState(() {
                      isPlaying = true;
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 120,
                  ),
                  child: RoundButton(
                    icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 120,
                ),
                child: GestureDetector(
                  onTap: () {
                    controller.reset();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                  //停止ボタン↓
                  child: const RoundButton(
                    icon: Icons.stop,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
