import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_overboard/src/circular_clipper.dart';
import 'package:flutter_overboard/src/page_model.dart';

class OverBoard extends StatefulWidget {
  final List<PageModel> pages;
  final Offset center;
  final bool showBullets;
  final VoidCallback finishCallback;

  const OverBoard({Key key, @required this.pages, this.center, this.showBullets, @required this.finishCallback}) : super(key: key);

  @override
  _OverBoardState createState() => _OverBoardState();
}

class _OverBoardState extends State<OverBoard> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  int _counter = 0, _last = 0;
  int _total = 0;
  double initial = 0, distance = 0;
  Random random = new Random();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _total = widget.pages.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getStack(),
    );
  }

  _getStack() {
    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        initial = details.globalPosition.dx;
      },
      onPanUpdate: (DragUpdateDetails details) {
        distance = details.globalPosition.dx - initial;
      },
      onPanEnd: (DragEndDetails details) {
        initial = 0.0;
        setState(() {
          _last = _counter;
        });
        if (distance > 1 && _counter > 0) {
          setState(() {
            _counter--;
          });
          _controller.forward(from: 0);
        } else if (distance < 0 && _counter < _total - 1) {
          setState(() {
            _counter++;
          });
          _controller.forward(from: 0);
        }
      },
      child: Stack(
        children: <Widget>[
          _getPage(_last),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return ClipOval(
                  clipper: CircularClipper(_animation.value, widget.center),
                  child: _getPage(_counter));
            },
            child: Container(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: _counter < _total - 1
                ? FlatButton(
                    padding: const EdgeInsets.all(20.0),
                    textColor: Colors.white,
                    child: Text("SKIP"),
                    onPressed: () {},
                  )
                : null,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _counter < _total - 1
                ? FlatButton(
                    padding: const EdgeInsets.all(20.0),
                    textColor: Colors.white,
                    child: Text("NEXT"),
                    onPressed: () {
                      setState(() {
                        _last = _counter;
                        _counter++;
                      });
                      _controller.forward(from: 0);
                    },
                  )
                : FlatButton(
                    padding: const EdgeInsets.all(20.0),
                    textColor: Colors.white,
                    child: Text("FINISH"),
                    onPressed: widget.finishCallback
                  ),
          ),
          (widget.showBullets ?? true) ? Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < _total; i++)
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 10.0,
                        width: 10.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (i == _counter ? Colors.white : Colors.white30)),
                      ),
                    )
                ],
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }

  _getPage(index) {
    PageModel page = widget.pages[index];
    return Container(
      width: double.infinity,
      color: page.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Transform(
            transform: new Matrix4.translationValues(
                0.0, 50.0 * (1.0 - _animation.value), 0.0),
            child: new Padding(
              padding: new EdgeInsets.only(bottom: 25.0),
              child: new Image.asset(page.imageAssetPath,
                  width: 300.0, height: 300.0),
            ),
          ),
          Padding(
            padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: new Text(
              page.title,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 34.0,
              ),
            ),
          ),
          Padding(
            padding: new EdgeInsets.only(bottom: 75.0, left: 30.0, right: 30.0),
            child: new Text(
              page.body,
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
