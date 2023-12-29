# flutter_overboard

[![pub package](https://img.shields.io/badge/pub-v3.1.3-blue)](https://pub.dev/packages/flutter_overboard)

Onboarding widget for flutter to create beautiful onboarding slides with minimal code.

## Demo

![Example Gif](https://github.com/kumar-aakash86/flutter_overboard/raw/master/screenshots/example.gif)

## Usage

Add following command in your **pubspec.yaml** & install package

`flutter_overboard:3.1.3`

or run

`flutter pub add flutter_overboard`

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

**That's it. You are done with the setup now try to run your app.**

**_To customize the circle reveal center point use (Overboard Widget)_**

```
    center: Offset(dx, dy);
```

**_To customize the text of buttons (Overboard Widget)_**

```
    skipText: "Go Out",
    nextText: "Go Forward",
    finishText: "END",
```

**_To customize the color of buttons (Overboard Widget)_**

```
    buttonColor: Colors.blue,
```

**_To customize the color of bullets (Overboard Widget)_**

```
    activeBulletColor: Colors.white,
    inactiveBulletColor: Colors.white30,
```

**_To customize the background of pages (Overboard Widget)_**

```
  backgroundProvider: NetworkImage('https://picsum.photos/720/1280')
```

OR

```
  backgroundProvider: ImageProvider('assets/images/bg.jpg')
```

**_To customize the color of page text (PageModel Widget)_**

```
    titleColor: Colors.blue,
    bodyColor: Colors.red,
```

**_To add the scroll support using keyboard & mouse wheel (Overboard Widget)_**

```
    allowScroll: true,
```

### Overboard Widget

| PROPERTY            | TYPE            | REQUIRED | DETAILS                                        |
| ------------------- | --------------- | -------- | ---------------------------------------------- |
| pages               | List<PageModel> | yes      | List of pages to render on-boarding            |
| center              | Offset          | no       | Offset to set center point of revealing circle |
| showBullets         | Boolean         | no       | Enable/disable bullets visibility              |
| skipText            | String          | no       | Customize skip button text                     |
| nextText            | String          | no       | Customize next button text                     |
| finishText          | String          | no       | Customize finish button text                   |
| buttonColor         | Color           | no       | Customize button color                         |
| activeBulletColor   | Color           | no       | Customize active bullet color                  |
| inactiveBulletColor | Color           | no       | Customize inactive bullet color                |
| backgroundProvider  | ImageProvider   | no       | Overboard background image provider            |
| skipCallback        | VoidCallback    | no       | Skip button click callback                     |
| finishCallback      | VoidCallback    | no       | Finish button click callback                   |

### PageModel Widget

| PROPERTY       | TYPE    | REQUIRED | DETAILS                                |
| -------------- | ------- | -------- | -------------------------------------- |
| color          | Color   | no       | Background color of the page           |
| imageAssetPath | String  | no       | Image path from asset to show in page  |
| title          | String  | no       | Title text of the page                 |
| body           | String  | no       | Body text of the page                  |
| child          | Widget  | no       | Custom widget to pass as image in page |
| doAnimateChild | Boolean | yes      | To enable/disable child animation      |
| doAnimateImage | Boolean | yes      | To enable/disable image animation      |
| titleColor     | Color   | no       | Change color of title text             |
| bodyColor      | Color   | no       | Change color of body text              |

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
