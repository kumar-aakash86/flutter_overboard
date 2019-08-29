import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_overboard/src/circular_clipper.dart';
import 'package:flutter_overboard/src/page_model.dart';

enum SwipeDirection { LEFT_TO_RIGHT, RIGHT_TO_LEFT, SKIP_TO_LAST }

class OverBoard extends StatefulWidget {
  final List<PageModel> pages;
  final Offset center;
  final bool showBullets;
  final VoidCallback finishCallback;

  const OverBoard(
      {Key key,
      @required this.pages,
      this.center,
      this.showBullets,
      @required this.finishCallback})
      : super(key: key);

  @override
  _OverBoardState createState() => _OverBoardState();
}

class _OverBoardState extends State<OverBoard> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  ScrollController _scrollController = new ScrollController();
  double _bulletPadding = 5.0, _bulletSize = 10.0, _bulletContainerWidth = 0;

  int _counter = 0, _last = 0;
  int _total = 0;
  double initial = 0, distance = 0;
  Random random = new Random();
  SwipeDirection _swipeDirection = SwipeDirection.RIGHT_TO_LEFT;

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
            _swipeDirection = SwipeDirection.LEFT_TO_RIGHT;
          });
          _animate();
        } else if (distance < 0 && _counter < _total - 1) {
          setState(() {
            _counter++;
            _swipeDirection = SwipeDirection.RIGHT_TO_LEFT;
          });
          _animate();
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                (_counter < _total - 1
                    ? FlatButton(
                        padding: const EdgeInsets.all(20.0),
                        textColor: Colors.white,
                        child: Text("SKIP"),
                        onPressed: _skip,
                      )
                    : FlatButton(
                        padding: const EdgeInsets.all(20.0),
                        textColor: widget.pages[_counter].color,
                        child: Text("SKIP"),
                        onPressed: _skip,
                      )),
                Expanded(
                  child: Center(child: LayoutBuilder(
                    builder: (context, constraints) {
                      _bulletContainerWidth = constraints.maxWidth - 40.0;
                      return Container(
                        padding: const EdgeInsets.all(20.0),
                        child: ((widget.showBullets ?? true)
                            ? SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    for (int i = 0; i < _total; i++)
                                      Padding(
                                        padding: EdgeInsets.all(_bulletPadding),
                                        child: Container(
                                          height: _bulletSize,
                                          width: _bulletSize,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (i == _counter
                                                  ? Colors.white
                                                  : Colors.white30)),
                                        ),
                                      )
                                  ],
                                ),
                              )
                            : Container()),
                      );
                    },
                  )),
                ),
                (_counter < _total - 1
                    ? FlatButton(
                        padding: const EdgeInsets.all(20.0),
                        textColor: Colors.white,
                        child: Text("NEXT"),
                        onPressed: _next,
                      )
                    : FlatButton(
                        padding: const EdgeInsets.all(20.0),
                        textColor: Colors.white,
                        child: Text("FINISH"),
                        onPressed: widget.finishCallback)),
              ],
            ),
          ),
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
            padding: new EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
            child: new Text(
              page.title,
              textAlign: TextAlign.center,
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

  _next() {
    setState(() {
      _swipeDirection = SwipeDirection.RIGHT_TO_LEFT;
      _last = _counter;
      _counter++;
    });
    _animate();
  }

  _skip() {
    setState(() {
      _swipeDirection = SwipeDirection.SKIP_TO_LAST;
      _last = _counter;
      _counter = _total - 1;
    });
    _animate();
  }

  _animate() {
    _controller.forward(from: 0);

    double _bulletDimension = (_bulletPadding * 2) + (_bulletSize);
    double _scroll = _bulletDimension * _counter;
    double _maxScroll = _bulletDimension * _total - 1;
    if (_scroll > _bulletContainerWidth &&
        _swipeDirection == SwipeDirection.RIGHT_TO_LEFT) {
      double _scrollDistance =
          (((_scroll - _bulletContainerWidth) ~/ _bulletDimension) + 1) *
              _bulletDimension;
      // print("scroll forward = ${_scroll } = ${_scrollDistance}  ===  ${_scroll - _scrollDistance}");
      _scrollController.animateTo(_scrollDistance,
          curve: Curves.easeIn, duration: Duration(milliseconds: 100));
    } else if (_scroll < (_maxScroll - _bulletContainerWidth) &&
        _swipeDirection == SwipeDirection.LEFT_TO_RIGHT) {
      // print("scroll back = ${_maxScroll - _bulletContainerWidth}");
      _scrollController.animateTo(_scroll,
          curve: Curves.easeIn, duration: Duration(milliseconds: 100));
    } else if (_swipeDirection == SwipeDirection.SKIP_TO_LAST) {
      _scrollController.animateTo(_maxScroll,
          curve: Curves.easeIn, duration: Duration(milliseconds: 100));
    }
  }
}
