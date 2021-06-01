import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'clock.dart';
import 'counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Clock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Super Clock'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  //tab widgets
  Counter _counterWidget = Counter();


  static const superRatio = 0.864;
  int _counter = 0;
  String _displayTime = '00:00:00';
  String _displaySuperTime = '00.00.00';
  String _displaySecondOfTheDay = '0';

  @override
  void initState() {
    _displayTime = '00:00:00';
    _displaySuperTime = '00.00.00';
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    Timer.periodic(Duration(milliseconds: 864), (Timer t) => _getSuperTime());
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm:ss').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _displayTime = formattedDateTime;
    });
  }

  void _getSuperTime() {
    final DateTime now = DateTime.now();

    int secondOfTheDay = now.hour * 3600 + now.minute * 60 + now.second;

    setState(() {
      _displaySecondOfTheDay = secondOfTheDay.toString();
      _displaySuperTime = (secondOfTheDay / superRatio).round().toString();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.watch_later_outlined),
            ),
            Tab(
              icon: Icon(Icons.timer),
            ),
            Tab(
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),

      body: TabBarView(controller: _tabController, children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _displaySuperTime,
            ),
            Text(
              'Time:',
            ),
            Text(
              _displayTime,
            ),
            Text(
              'Second of the day:',
            ),
            Text(
              _displaySecondOfTheDay,
            ),
          ],
        ), //clockWidget(context),
        clockWidget,
        _counterWidget,
      ]),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
