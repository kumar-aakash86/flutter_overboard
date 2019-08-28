import 'package:flutter/material.dart';

import 'package:flutter_overboard/flutter_overboard.dart';

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
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        pages: pages,
        showBullets: true,
        finishCallback: () {
          _globalKey.currentState.showSnackBar(SnackBar(
            content: Text("Finish clicked"),
          ));
        },
      ),
    );
  }

  final pages = [
    new PageModel(const Color(0xFF0097A7), 'assets/01.png', 'Screen 1',
        'Share your ideas with the team'),
    new PageModel(const Color(0xFF536DFE), 'assets/02.png', 'Screen 2',
        'See the increase in productivity & output'),
    new PageModel(const Color(0xFF9B90BC), 'assets/03.png', 'Screen 3',
        'Connect with the people from different places'),
  ];
}
