import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

class OverBoardAnimator {
  TickerProvider _vsync;
  AnimationController _controller;
  Animation _animation;

  //  static final OverBoardAnimator _singleton = new OverBoardAnimator._internal();

  // factory OverBoardAnimator(_vsync) {
  //   _singleton._vsync = _vsync;
  //   _singleton._controller = AnimationController(
  //       vsync: _vsync, duration: const Duration(milliseconds: 500));
  //   _singleton._animation = CurvedAnimation(parent: _singleton._controller, curve: Curves.easeIn);
  //   return _singleton;
  // }

  // OverBoardAnimator._internal();

  OverBoardAnimator(vsync) {
    this._vsync = vsync;
    _controller = AnimationController(
        vsync: _vsync, duration: const Duration(milliseconds: 500));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    print('creating new animator');
  }

  AnimationController getController() {
    return _controller;
  }

  Animation getAnimator() {
    return _animation;
  }

  dispose() {
    _controller.dispose();
  }
}
