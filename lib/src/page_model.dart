import 'dart:ui';

import 'package:flutter/cupertino.dart';

class PageModel {
  Color color;
  String imageAssetPath;
  String title;
  String body;
  Widget child;
  bool doAnimateChild;
  bool doAnimateImage;

  PageModel(
      {@required this.color,
      @required this.imageAssetPath,
      @required this.title,
      @required this.body,
      @required this.doAnimateImage});

  PageModel.withChild(
      {@required this.child,
      @required this.color,
      @required this.doAnimateChild});
}
