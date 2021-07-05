import 'package:flutter/widgets.dart';

class PageItem {
  const PageItem(
      {required this.title, required this.iconData, required this.builder});
  final String title;
  final IconData iconData;
  final WidgetBuilder builder;
}
