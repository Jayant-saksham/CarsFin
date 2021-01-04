import 'package:flutter/material.dart';
import 'package:Cars/UI/BottomNavBar/BottomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/done.png",
              width: 90,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "You car has been",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "booked successfully",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Center(
            child: Text(
              "CarsFin team will get back to you",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavScreen(
                    phoneNumber: FirebaseAuth.instance.currentUser.phoneNumber,
                    // isAgency: false,
                  ),
                ),
              );
            },
            color: Colors.indigo,
            child: Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
