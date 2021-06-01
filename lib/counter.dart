import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  //static int _counter = 0;



  @override
  State<StatefulWidget> createState() {
    CounterState _counterState =CounterState();
    //_counterState.counter = _counter;
    return _counterState;
  }
}

class CounterState extends State<Counter> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Counter:'),
          Text('$counter'),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          )
        ]);
  }
}
