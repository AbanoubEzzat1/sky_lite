import 'package:flutter/widgets.dart';

Widget textWidget({
  required String text,
  required double fontSize,
  required Color color,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
    ),
  );
}
