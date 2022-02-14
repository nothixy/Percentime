import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

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

const len = 500.0;
bool showInfo = false;

class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  _MyApp2 createState() => _MyApp2();
}

class _MyApp2 extends State<MyApp2> {
  late double percentageSecond;
  late double percentageMinute;
  late double percentageHour;
  late double percentageDay;
  late double percentageWeek;
  late double percentageMonth;
  late double percentageYear;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    percentageSecond = now.millisecond / 1000;
    percentageMinute = (now.second + (now.millisecond / 1000)) / 60;
    percentageHour = (now.minute + (now.second / 60)) / 60;
    percentageDay = (now.hour + (now.minute / 60)) / 24;
    percentageWeek = (now.weekday - 1 + (now.hour / 24)) / 7;
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
    percentageMonth = (now.day + (now.hour / 24)) / monLen;
    percentageYear = (now.month + (now.month / 12)) / 12;
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
        percentageYear = (now.month + (now.month / 12)) / 12;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double len = min(width, height) * .90;
    double strokeWidth = 1/100 * len;
    return MaterialApp(
        home: Scaffold(
          body: InkWell(
                onTap: () {
                  setState(() {
                    showInfo = !showInfo;
                  });
                },
                child: Center(
                    child: Stack(
                      children: [
                        Visibility(
                          visible: !showInfo,
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  width: 7/7 * len,
                                  height: 7/7 * len,
                                  child: SizedBox(
                                    width: 7/7 * len,
                                    height: 7/7 * len,
                                    child: CircularProgressIndicator(
                                      strokeWidth: strokeWidth,
                                      color: const Color.fromARGB(255, 255, 0, 0),
                                      value: percentageSecond,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: 6/7 * len,
                                  height: 6/7 * len,
                                  child: SizedBox(
                                    width: 6/7 * len,
                                    height: 6/7 * len,
                                    child: CircularProgressIndicator(
                                      strokeWidth: strokeWidth,
                                      color: const Color.fromARGB(255, 255, 0, 255),
                                      value: percentageMinute,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: 5/7 * len,
                                  height: 5/7 * len,
                                  child: SizedBox(
                                    width: 5/7 * len,
                                    height: 5/7 * len,
                                    child: CircularProgressIndicator(
                                      strokeWidth: strokeWidth,
                                      color: const Color.fromARGB(255, 0, 0, 255),
                                      value: percentageHour,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: 4/7 * len,
                                  height: 4/7 * len,
                                  child: SizedBox(
                                    width: 4/7 * len,
                                    height: 4/7 * len,
                                    child: CircularProgressIndicator(
                                      strokeWidth: strokeWidth,
                                      color: const Color.fromARGB(255, 0, 255, 255),
                                      value: percentageDay,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: 3/7 * len,
                                  height: 3/7 * len,
                                  child: SizedBox(
                                    width: 3/7 * len,
                                    height: 3/7 * len,
                                    child: CircularProgressIndicator(
                                      strokeWidth: strokeWidth,
                                      color: const Color.fromARGB(255, 0, 255, 0),
                                      value: percentageWeek,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: 2/7 * len,
                                  height: 2/7 * len,
                                  child: SizedBox(
                                    width: 2/7 * len,
                                    height: 2/7 * len,
                                    child: CircularProgressIndicator(
                                      strokeWidth: strokeWidth,
                                      color: const Color.fromARGB(255, 255, 255, 0),
                                      value: percentageMonth,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: 1/7 * len,
                                  height: 1/7 * len,
                                  child: SizedBox(
                                    width: 1/7 * len,
                                    height: 1/7 * len,
                                    child: CircularProgressIndicator(
                                      strokeWidth: strokeWidth,
                                      color: const Color.fromARGB(255, 255, 0, 0),
                                      value: percentageYear,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: showInfo,
                          child: Center(
                            child: SizedBox(
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
                            )
                          )
                        )
                      ]
                    ),
                )
              )
          ),
    );
  }
}