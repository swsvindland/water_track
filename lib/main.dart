import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'components/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: HomePage(),
    );
  }
}

_HomePageState homePageState;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() {
    homePageState = _HomePageState();
    return homePageState;
  }
}

class _HomePageState extends State<HomePage> {
  Widget body = LoginPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WaterTrack'),
      ),
      body: body,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var email, uid;
  int _counter = 8;
  static DateTime now = new DateTime.now();
  String formattedDate = DateFormat('yyyyMMdd').format(now);

  @override
  void didChangeDependencies() {
    Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .snapshots()
        .listen((data) => {uid = data.documents[0]['uid']});
    Firestore.instance
        .collection('drinks')
        .document(uid)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        _counter = ds[formattedDate];
      });
    });
    super.didChangeDependencies();
  }

  void _incrementCounter() {
    setState(() {
      _counter += 8;
    });
    Firestore.instance
        .collection('drinks')
        .document(uid)
        .setData({formattedDate: _counter});
  }

  void _decrementCounter() {
    setState(() {
      _counter -= 8;
      if (_counter < 0) {
        _counter = 0;
      }
    });
    Firestore.instance
        .collection('drinks')
        .document(uid)
        .setData({formattedDate: _counter});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[100],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.opacity),
              iconSize: 150.0,
              tooltip: 'Add Water',
              color: Colors.white,
              onPressed: () {
                _incrementCounter();
              },
            ),
            Text(
              '$_counter oz out of 128 oz',
              style: Theme.of(context).textTheme.display1,
            ),
            IconButton(
              icon: Icon(Icons.opacity),
              iconSize: 50.0,
              tooltip: 'Remove Water',
              color: Colors.white,
              onPressed: () {
                _decrementCounter();
              },
            ),
          ],
        ),
      ),
    );
  }
}
