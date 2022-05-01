import 'package:flutter/cupertino.dart';

class PageModel {
  /// Background color of the page
  Color? color;

  /// Image path from asset to show in page
  String? imageAssetPath;

  /// Image width
  double? imageWidth;

  /// Image width
  double? imageHeight;

  /// Title text of the page
  String? title;

  /// Title text style of the page
  TextStyle? titleStyle;

  /// Body text of the page
  String? body;

  /// Body text style of the page
  TextStyle? bodyStyle;

  /// Padding around the body
  EdgeInsetsGeometry bodyPadding;

  /// Height of the body
  double? bodyHeight;

  /// Custom widget to pass as image in page
  Widget? child;

  /// To enable/disable child animation
  bool doAnimateChild = false;

  /// To enable/disable image animation
  bool doAnimateImage = false;

  /// Change color of title text
  Color? titleColor;

  /// Change color of body text
  Color? bodyColor;

  /// Create page model with image in show in on-boarding widget
  PageModel({
    this.color,
    this.titleColor,
    this.titleStyle,
    this.bodyColor,
    this.bodyStyle,
    this.bodyHeight,
    required this.imageAssetPath,
    required this.title,
    required this.body,
    this.doAnimateImage = false,
    this.imageWidth = 300,
    this.imageHeight = 300,
    this.bodyPadding = const EdgeInsets.only(bottom: 175.0, left: 30.0,
        right: 30.0),
  });

  /// Create page model with custom child in show in on-boarding widget
  PageModel.withChild(
      {required this.child,
      required this.color,
      this.titleColor,
      this.bodyColor,
      this.doAnimateChild = false,
      this.bodyPadding = const EdgeInsets.only(bottom: 175.0, left: 30.0,
          right: 30.0)});
}
