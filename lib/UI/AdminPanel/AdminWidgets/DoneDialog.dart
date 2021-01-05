import 'package:flutter/material.dart';

class leadDialog extends StatelessWidget {
  String carNumber;
  String carModel;
  String carName;

  leadDialog({this.carModel, this.carName, this.carNumber});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300.0,
        width: 360.0,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close_outlined),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Car Approved',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/images/done.png",
                    width: 30,
                  ),
                ],
              ),
            ),
            Text(
              carNumber,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              carModel,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              carName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
