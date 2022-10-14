import 'package:flutter/material.dart';

class Widgets {
  static Widget richText({required String title, required String description}) {
    return Text.rich(
      TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        children: [
          TextSpan(
            text: title + "  ",
          ),
          TextSpan(
            text: description,
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
