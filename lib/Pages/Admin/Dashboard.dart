import 'package:flutter/material.dart';
import 'CardWidget.dart';

Widget dashboard() {
  return Padding(
    padding: const EdgeInsets.only(
      top: 20,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CardWidget(
              backgroundColor: Colors.white,
              users: 5,
              integerColor: Colors.orange,
              titleColor: Colors.grey,
            ),
            CardWidget(
              backgroundColor: Colors.white,
              users: 5,
              integerColor: Colors.orange,
              titleColor: Colors.grey,
            ),
          ],
        )
      ],
    ),
  );
}
