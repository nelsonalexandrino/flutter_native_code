import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _batterLevel;

  Future<void> _getBatterLevel() async {
    const platform = MethodChannel('course.flutter.dev/battery');
    try {
      final batterLevel = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _batterLevel = batterLevel;
      });
    } on PlatformException catch (error) {
      setState(() {
        _batterLevel = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getBatterLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('Batter level: $_batterLevel'),
      ),
    );
  }
}
