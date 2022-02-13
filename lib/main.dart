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
    return MaterialApp(
        home: Scaffold(
          body: Center(
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showInfo = !showInfo;
                    });
                  },
                  child:
                  Align(
                    child: Stack(
                      children: [
                        Center(
                          child : SizedBox(
                              width: 7/7 * len,
                              height: 7/7 * len,
                              child: Stack(
                                  children: <Widget> [
                                    Center(
                                      child: SizedBox(
                                        width: 7/7 * len,
                                        height: 7/7 * len,
                                        child: CircularProgressIndicator(
                                          key : const Key('progress7'),
                                          strokeWidth: 1/140 * len,
                                          color: const Color.fromARGB(255, 255, 0, 0),
                                          value: percentageSecond,
                                          semanticsLabel: 'Linear progress indicator',
                                        ),
                                      ),
                                    ),
                                    Visibility (
                                      visible: showInfo,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text("Hour : " + ((percentageSecond*10000).round()/100).toString() + "%"),
                                      ),
                                    )
                                  ]
                              )
                          ),
                        ),
                        Center(
                          child : SizedBox(
                              width: 6/7 * len,
                              height: 6/7 * len,
                              child: Stack(
                                  children: <Widget> [
                                    Center(
                                      child: SizedBox(
                                        width: 6/7 * len,
                                        height: 6/7 * len,
                                        child: CircularProgressIndicator(
                                          key : const Key('progress7'),
                                          strokeWidth: 1/140 * len,
                                          color: const Color.fromARGB(255, 255, 0, 255),
                                          value: percentageMinute,
                                          semanticsLabel: 'Linear progress indicator',
                                        ),
                                      ),
                                    ),
                                    Visibility (
                                      visible: showInfo,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text("Minute : " + ((percentageMinute*10000).round()/100).toString() + "%"),
                                      ),
                                    )
                                  ]
                              )
                          ),
                        ),
                        Center(
                          child : SizedBox(
                              width: 5/7 * len,
                              height: 5/7 * len,
                              child: Stack(
                                  children: <Widget> [
                                    Center(
                                      child: SizedBox(
                                        width: 5/7 * len,
                                        height: 5/7 * len,
                                        child: CircularProgressIndicator(
                                          key : const Key('progress7'),
                                          strokeWidth: 1/140 * len,
                                          color: const Color.fromARGB(255, 0, 0, 255),
                                          value: percentageHour,
                                          semanticsLabel: 'Linear progress indicator',
                                        ),
                                      ),
                                    ),
                                    Visibility (
                                      visible: showInfo,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text("Hour : " + ((percentageHour*10000).round()/100).toString() + "%"),
                                      ),
                                    )
                                  ]
                              )
                          ),
                        ),
                        Center(
                          child : SizedBox(
                              width: 4/7 * len,
                              height: 4/7 * len,
                              child: Stack(
                                  children: <Widget> [
                                    Center(
                                      child: SizedBox(
                                        width: 4/7 * len,
                                        height: 4/7 * len,
                                        child: CircularProgressIndicator(
                                          key : const Key('progress7'),
                                          strokeWidth: 1/140 * len,
                                          color: const Color.fromARGB(255, 0, 255, 255),
                                          value: percentageDay,
                                          semanticsLabel: 'Linear progress indicator',
                                        ),
                                      ),
                                    ),
                                    Visibility (
                                      visible: showInfo,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text("Day : " + ((percentageDay*10000).round()/100).toString() + "%"),
                                      ),
                                    )
                                  ]
                              )
                          ),
                        ),
                        Center(
                          child : SizedBox(
                              width: 3/7 * len,
                              height: 3/7 * len,
                              child: Stack(
                                  children: <Widget> [
                                    Center(
                                      child: SizedBox(
                                        width: 3/7 * len,
                                        height: 3/7 * len,
                                        child: CircularProgressIndicator(
                                          key : const Key('progress7'),
                                          strokeWidth: 1/140 * len,
                                          color: const Color.fromARGB(255, 0, 255, 0),
                                          value: percentageWeek,
                                          semanticsLabel: 'Linear progress indicator',
                                        ),
                                      ),
                                    ),
                                    Visibility (
                                      visible: showInfo,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text("Week : " + ((percentageWeek*10000).round()/100).toString() + "%"),
                                      ),
                                    )
                                  ]
                              )
                          ),
                        ),
                        Center(
                          child : SizedBox(
                              width: 2/7 * len,
                              height: 2/7 * len,
                              child: Stack(
                                  children: <Widget> [
                                    Center(
                                      child: SizedBox(
                                        width: 2/7 * len,
                                        height: 2/7 * len,
                                        child: CircularProgressIndicator(
                                          key : const Key('progress7'),
                                          strokeWidth: 1/140 * len,
                                          color: const Color.fromARGB(255, 255, 255, 0),
                                          value: percentageMonth,
                                          semanticsLabel: 'Linear progress indicator',
                                        ),
                                      ),
                                    ),
                                    Visibility (
                                      visible: showInfo,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text("Month : " + ((percentageMonth*10000).round()/100).toString() + "%"),
                                      ),
                                    )
                                  ]
                              )
                          ),
                        ),
                        Center(
                          child : SizedBox(
                              width: 1/7 * len,
                              height: 1/7 * len,
                              child: Stack(
                                  children: <Widget> [
                                    Center(
                                      child: SizedBox(
                                        width: 1/7 * len,
                                        height: 1/7 * len,
                                        child: CircularProgressIndicator(
                                          key : const Key('progress7'),
                                          strokeWidth: 1/140 * len,
                                          color: const Color.fromARGB(255, 255, 0, 0),
                                          value: percentageYear,
                                          semanticsLabel: 'Linear progress indicator',
                                        ),
                                      ),
                                    ),
                                    Visibility (
                                      visible: showInfo,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text("Year : " + ((percentageYear*10000).round()/100).toString() + "%"),
                                      ),
                                    )
                                  ]
                              )
                          ),
                        ),
                      ],
                    ),
                  )
              )
          ),
        )
    );
  }
}