# flutter_overboard  
[![pub package](https://img.shields.io/badge/pub-v1.0.3-blue)](https://pub.dev/packages/flutter_overboard)  


Onboarding widget for flutter to create beautiful onboarding slides with minimal code.


## Demo   
 ![Example Gif](https://github.com/kumar-aakash86/flutter_overboard/blob/master/screenshots/example.gif)


## Usage
Add following command in your **pubspec.yaml** & install package

`flutter_overboard:1.0.0`
    


Import in your dart page
```
import 'package:flutter_overboard/flutter_overboard.dart';
```  
  
  
Create a pages array like   
```
    final pages = [
        new PageModel(const Color(0xFF0097A7), 'assets/01.png', 'Screen 1',
            'Share your ideas with the team'),
        new PageModel(const Color(0xFF536DFE), 'assets/02.png', 'Screen 2',
            'See the increase in productivity & output'),
        new PageModel(const Color(0xFF9B90BC), 'assets/03.png', 'Screen 3',
            'Connect with the people from different places'),
    ];
```   
  
  
Add follwing in you dart code widget
```
    OverBoard(
        pages: pages,
        showBullets: true,
        finishCallback: () {
          // WRITE THE FINISH BUTTON ACTION HERE
        },
      ),
```
  
  

That's it. You are done with the setup now try to run your app.

## Example
```
import 'package:flutter/material.dart';

import 'package:flutter_overboard/flutter_overboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
```