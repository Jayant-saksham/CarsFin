import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  int users;
  Color backgroundColor;
  Color titleColor;
  Color integerColor;
  CardWidget(
      {this.users, this.backgroundColor, this.integerColor, this.titleColor});
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: Container(
        height: MediaQuery.of(context).size.width / 2.6,
        width: MediaQuery.of(context).size.width / 2.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Users",
              style: TextStyle(
                  color: widget.titleColor, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 35,
            ),
            Text(
              "${widget.users}",
              style: TextStyle(
                  color: widget.integerColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
