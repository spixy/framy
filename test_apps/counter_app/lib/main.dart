import 'package:flutter/material.dart';
import 'package:framy_annotation/framy_annotation.dart';

void main() {
  runApp(MyApp());
}

@FramyApp()
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getThemeData(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

@FramyTheme()
ThemeData getThemeData() => ThemeData(errorColor: Colors.redAccent);

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CounterTitle(),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: CounterFAB(onPressed: _incrementCounter),
    );
  }
}

@FramyWidget()
class CounterFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const CounterFAB({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: Key('MyCounterFAB'),
      onPressed: onPressed,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}

@FramyWidget()
class CounterTitle extends StatelessWidget {
  final String verb;

  const CounterTitle({Key key, this.verb}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      'You have ${verb ?? 'pushed'} the button this many times:',
    );
  }
}
