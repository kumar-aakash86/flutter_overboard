# flutter_overboard  
[![pub package](https://img.shields.io/badge/pub-v1.1.4-blue)](https://pub.dev/packages/flutter_overboard)  


Onboarding widget for flutter to create beautiful onboarding slides with minimal code.


## Demo   
 ![Example Gif](https://github.com/kumar-aakash86/flutter_overboard/blob/master/screenshots/example.gif)


## Usage
Add following command in your **pubspec.yaml** & install package

`flutter_overboard:1.1.4`
    


_**Import in your dart page**_
```
import 'package:flutter_overboard/flutter_overboard.dart';
```  
  
  
**_Create a pages array like_**   
```
    final pages = [
        new PageModel(
            color: const Color(0xFF0097A7),
            imageAssetPath: 'assets/01.png',
            title: 'Screen 1',
            body: 'Share your ideas with the team',
            doAnimateImage: true),
        new PageModel(
            color: const Color(0xFF536DFE),
            imageAssetPath: 'assets/02.png',
            title: 'Screen 2',
            body: 'See the increase in productivity & output',
            doAnimateImage: true),
        new PageModel(
            color: const Color(0xFF9B90BC),
            imageAssetPath: 'assets/03.png',
            title: 'Screen 3',
            body: 'Connect with the people from different places',
            doAnimateImage: true),
    ];
```   
  
**_You can also pass widgets as page model_** 
```
    PageModel.withChild(
        child: new Padding(
          padding: new EdgeInsets.only(bottom: 25.0),
          child: new Image.asset('assets/02.png', width: 300.0, height: 300.0),
        ),
        color: const Color(0xFF5886d6),
        doAnimateChild: true)
```
  
  
**_Add follwing in you dart code widget_**
```
    OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          // WRITE SKIP BUTTON ACTION HERE
        },
        finishCallback: () {
          // WRITE THE FINISH BUTTON ACTION HERE
        },
      ),
```
  
  
**_To customize the circle reveal center point use_**
```
    center: Offset(dx, dy);
```
  
  

**That's it. You are done with the setup now try to run your app.**

## Example
```
import 'package:flutter/material.dart';

import 'package:flutter_overboard/flutter_overboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Overboard Demo',
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
        skipCallback: () {
          _globalKey.currentState.showSnackBar(SnackBar(
            content: Text("Skip clicked"),
          ));
        },
        finishCallback: () {
          _globalKey.currentState.showSnackBar(SnackBar(
            content: Text("Finish clicked"),
          ));
        },
      ),
    );
  }

  final pages = [
        PageModel(
            color: const Color(0xFF0097A7),
            imageAssetPath: 'assets/01.png',
            title: 'Screen 1',
            body: 'Share your ideas with the team',
            doAnimateImage: true),
        PageModel(
            color: const Color(0xFF536DFE),
            imageAssetPath: 'assets/02.png',
            title: 'Screen 2',
            body: 'See the increase in productivity & output',
            doAnimateImage: true),
        PageModel(
            color: const Color(0xFF9B90BC),
            imageAssetPath: 'assets/03.png',
            title: 'Screen 3',
            body: 'Connect with the people from different places',
            doAnimateImage: true),
        PageModel.withChild(
            child: Padding(
              padding: EdgeInsets.only(bottom: 25.0),
              child: Image.asset('assets/02.png', width: 300.0, height: 300.0),
            ),
            color: const Color(0xFF5886d6),
            doAnimateChild: true)
  ];
}
```


# LICENSE
[MIT LICENSE](https://github.com/kumar-aakash86/flutter_overboard/blob/master/LICENSE.md)
