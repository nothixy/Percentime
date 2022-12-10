import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wearable_rotary/wearable_rotary.dart';
import 'package:wear/wear.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyApp2());
  }
}
bool showInfo = false;

class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  _MyApp2 createState() => _MyApp2();
}

class _MyApp2 extends State<MyApp2> {
  double percentageSecond = 0;
  double percentageMinute = 0;
  double percentageHour = 0;
  double percentageDay = 0;
  double percentageWeek = 0;
  double percentageMonth = 0;
  double percentageYear = 0;
  int ttl = 7;
  int cnt = 0;
  int threshold = 10;
  Color backgroundColor = Colors.transparent;
  ValueNotifier<WearMode> ambientMode = ValueNotifier<WearMode>(WearMode.active);
  late StreamSubscription<RotaryEvent> rotarySubscription;


  @override
  void dispose() {
    rotarySubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    /*ambientMode.addListener(() async {
        if (ambientMode.value == WearMode.active) {
          // setState(() {
            backgroundColor = Colors.transparent;
          // });
          sleep(const Duration(milliseconds: 200));
          print("Done");
          // setState(() {
            backgroundColor = Theme.of(context).canvasColor;
          // });
        } else {
          // setState(() {
            backgroundColor = Colors.transparent;
          // });
          sleep(const Duration(milliseconds: 200));
          // setState(() {
            backgroundColor = Colors.black;
          // });
        }
    });*/
    rotarySubscription = rotaryEvents.listen((RotaryEvent event) {
      // print(event.magnitude!);
      // if (event.magnitude != null && event.magnitude! > 4) {
        if (event.direction == RotaryDirection.clockwise) {
          if (cnt < 0) cnt = 0;
          cnt++;
          if (ttl > 1 && cnt > threshold) {
            cnt = 0;
            setState(() {
              ttl--;
            });
          }
        } else if (event.direction == RotaryDirection.counterClockwise) {
          if (cnt > 0) cnt = 0;
          cnt--;
          if (ttl < 7 && cnt < -threshold) {
            cnt = 0;
            setState(() {
              ttl++;
            });
          }
        }
      // }
    });
    Timer.periodic(const Duration(milliseconds: 10), (Timer t) {
      DateTime now = DateTime.now();
      int monLen = 0;
      switch(now.month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
          monLen = 30;
          break;
        case 2:
          monLen = (now.year % 4 == 0 ? 29 : 28);
          break;
        case 4:
        case 6:
        case 9:
        case 11:
          monLen = 30;
          break;
      }
      setState(() {
        percentageSecond = now.millisecond / 1000;
        percentageMinute = (now.second + (now.millisecond / 1000)) / 60;
        percentageHour = (now.minute + (now.second / 60)) / 60;
        percentageDay = (now.hour + (now.minute / 60)) / 24;
        percentageWeek = (now.weekday - 1 + (now.hour / 24)) / 7;
        percentageMonth = (now.day + (now.hour / 24)) / monLen;
        percentageYear = (now.month - 1 + now.day / monLen) / 12;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double len = min(width, height) * .80;
    double strokeWidth = 1/100 * len;
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
            onTap: () {
              setState(() {
                showInfo = !showInfo;
              });
            },
            behavior: HitTestBehavior.translucent,
            child: WatchShape(
                builder: (BuildContext context, WearShape shape, Widget? child) { return child!; },
                child: AmbientMode (
                  builder: (BuildContext context, WearMode mode, Widget? child) {
                    ambientMode.value = mode;
                    return AnimatedContainer(
                      color: mode == WearMode.ambient ? Colors.black : Theme.of(context).canvasColor,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: Stack(
                      children: [
                        Visibility(
                          visible: !showInfo,
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  width: ttl/ttl * len,
                                  height: ttl/ttl * len,
                                  child: SizedBox(
                                      width: ttl/ttl * len,
                                      height: ttl/ttl * len,
                                      child: Stack(
                                        children: <Widget?>[
                                          Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1),
                                              color: const Color.fromARGB(255, 255, 0, 0),
                                              value: percentageSecond,
                                            ),
                                          ),
                                          mode == WearMode.ambient ? Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1) * 1.2,
                                              color: Colors.black,
                                              value: (percentageSecond * 100 - len/(pi*(ttl)/ttl*len/2)) % 100 / 100,
                                            ),
                                          ) : null,
                                        ].whereType<Widget>().toList(),
                                      )
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: (ttl-1)/ttl * len,
                                  height: (ttl-1)/ttl * len,
                                  child: SizedBox(
                                      width: (ttl-1)/ttl * len,
                                      height: (ttl-1)/ttl * len,
                                      child: Stack(
                                        children: <Widget?>[
                                          Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1),
                                              color: const Color.fromARGB(255, 255, 0, 255),
                                              value: percentageMinute,
                                            ),
                                          ),
                                          mode == WearMode.ambient ? Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1) * 1.2,
                                              color: Colors.black,
                                              value: (percentageMinute * 100 - len/(pi*(ttl-1)/ttl*len/2)) % 100 / 100,
                                            ),
                                          ) : null,
                                        ].whereType<Widget>().toList(),
                                      )
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: (ttl-2)/ttl * len,
                                  height: (ttl-2)/ttl * len,
                                  child: SizedBox(
                                      width: (ttl-2)/ttl * len,
                                      height: (ttl-2)/ttl * len,
                                      child: Stack(
                                        children: <Widget?>[
                                          Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1),
                                              color: const Color.fromARGB(255, 0, 0, 255),
                                              value: percentageHour,
                                            ),
                                          ),
                                          mode == WearMode.ambient ? Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1) * 1.2,
                                              color: Colors.black,
                                              value: (percentageHour * 100 - len/(pi*(ttl-2)/ttl*len/2)) % 100 / 100,
                                            ),
                                          ) : null,
                                        ].whereType<Widget>().toList(),
                                      )
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: (ttl-3)/ttl * len,
                                  height: (ttl-3)/ttl * len,
                                  child: SizedBox(
                                    width: (ttl-3)/ttl * len,
                                    height: (ttl-3)/ttl * len,
                                      child: Stack(
                                        children: <Widget?>[
                                          Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1),
                                              color: const Color.fromARGB(255, 0, 255, 255),
                                              value: percentageDay,
                                            ),
                                          ),
                                          mode == WearMode.ambient ? Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1) * 1.2,
                                              color: Colors.black,
                                              value: (percentageDay * 100 - len/(pi*(ttl-3)/ttl*len/2)) % 100 / 100,
                                            ),
                                          ) : null,
                                        ].whereType<Widget>().toList(),
                                      )
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: (ttl-4)/ttl * len,
                                  height: (ttl-4)/ttl * len,
                                  child: SizedBox(
                                    width: (ttl-4)/ttl * len,
                                    height: (ttl-4)/ttl * len,
                                      child: Stack(
                                        children: <Widget?>[
                                          Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1),
                                              color: const Color.fromARGB(255, 0, 255, 0),
                                              value: percentageWeek,
                                            ),
                                          ),
                                          mode == WearMode.ambient ? Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1) * 1.2,
                                              color: Colors.black,
                                              value: (percentageWeek * 100 - len/(pi*(ttl-4)/ttl*len/2)) % 100 / 100,
                                            ),
                                          ) : null,
                                        ].whereType<Widget>().toList(),
                                      )
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: (ttl-5)/ttl * len,
                                  height: (ttl-5)/ttl * len,
                                  child: SizedBox(
                                    width: (ttl-5)/ttl * len,
                                    height: (ttl-5)/ttl * len,
                                      child: Stack(
                                        children: <Widget?>[
                                          Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1),
                                              color: const Color.fromARGB(255, 255, 255, 0),
                                              value: percentageMonth,
                                            ),
                                          ),
                                          mode == WearMode.ambient ? Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1) * 1.2,
                                              color: Colors.black,
                                              value: (percentageMonth * 100 - len/(pi*(ttl-5)/ttl*len/2)) % 100 / 100,
                                            ),
                                          ) : null,
                                        ].whereType<Widget>().toList(),
                                      )
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: (ttl-6)/ttl * len,
                                  height: (ttl-6)/ttl * len,
                                  child: SizedBox(
                                    width: (ttl-6)/ttl * len,
                                    height: (ttl-6)/ttl * len,
                                      child: Stack(
                                        children: <Widget?>[
                                          Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1),
                                              color: const Color.fromARGB(255, 255, 0, 0),
                                              value: percentageYear,
                                            ),
                                          ),
                                          mode == WearMode.ambient ? Positioned.fill(
                                            child: CircularProgressIndicator(
                                              strokeWidth: strokeWidth * (mode == WearMode.ambient ? 2 : 1) * 1.2,
                                              color: Colors.black,
                                              value: (percentageYear * 100 - len/(pi*(ttl-6)/ttl*len/2)) % 100 / 100,
                                            ),
                                          ) : null,
                                        ].whereType<Widget>().toList(),
                                      )
                                  ),
                                ),
                              ),
                            ].sublist(0, ttl),
                          ),
                        ),
                        Visibility(
                          visible: showInfo,
                          child: Center(child: SizedBox(
                            width: len,
                            height: len,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 1/7 * len,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text("Second : " + (((percentageSecond*100).round())).toInt().toString() + "%")
                                      ),
                                      Expanded(
                                        child: LinearProgressIndicator(
                                            minHeight: 1/100 * len,
                                            color: const Color.fromARGB(255, 255, 0, 0),
                                            backgroundColor: const Color.fromARGB(50, 255, 0, 0),
                                            value: percentageSecond
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1/7 * len,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text("Minute : " + (((percentageMinute*100).round())).toInt().toString() + "%")
                                      ),
                                      Expanded(
                                        child: LinearProgressIndicator(
                                            minHeight: 1/100 * len,
                                            color: const Color.fromARGB(255, 255, 0, 255),
                                            backgroundColor: const Color.fromARGB(50, 255, 0, 255),
                                            value: percentageMinute
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1/7 * len,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text("Hour : " + (((percentageHour*100).round())).toInt().toString() + "%")
                                      ),
                                      Expanded(
                                        child: LinearProgressIndicator(
                                            minHeight: 1/100 * len,
                                            color: const Color.fromARGB(255, 0, 0, 255),
                                            backgroundColor: const Color.fromARGB(50, 0, 0, 255),
                                            value: percentageHour
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1/7 * len,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text("Day : " + (((percentageDay*100).round())).toInt().toString() + "%")
                                      ),
                                      Expanded(
                                        child: LinearProgressIndicator(
                                            minHeight: 1/100 * len,
                                            color: const Color.fromARGB(255, 0, 255, 255),
                                            backgroundColor: const Color.fromARGB(50, 0, 255, 255),
                                            value: percentageDay
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1/7 * len,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text("Week : " + (((percentageWeek*100).round())).toInt().toString() + "%")
                                      ),
                                      Expanded(
                                        child: LinearProgressIndicator(
                                            minHeight: 1/100 * len,
                                            color: const Color.fromARGB(255, 0, 255, 0),
                                            backgroundColor: const Color.fromARGB(50, 0, 255, 0),
                                            value: percentageWeek
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1/7 * len,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text("Month : " + (((percentageMonth*100).round())).toInt().toString() + "%")
                                      ),
                                      Expanded(
                                        child: LinearProgressIndicator(
                                            minHeight: 1/100 * len,
                                            color: const Color.fromARGB(255, 255, 255, 0),
                                            backgroundColor: const Color.fromARGB(50, 255, 255, 0),
                                            value: percentageMonth
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1/7 * len,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text("Year : " + (((percentageYear*100).round())).toInt().toString() + "%")
                                      ),
                                      Expanded(
                                        child: LinearProgressIndicator(
                                            minHeight: 1/100 * len,
                                            color: const Color.fromARGB(255, 255, 0, 0),
                                            backgroundColor: const Color.fromARGB(50, 255, 0, 0),
                                            value: percentageYear
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ),
                        ),
                      ],
                    ),
                    );

                  }
                ),
              ),
        ),
      ),
    );
  }
}