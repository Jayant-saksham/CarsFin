import 'package:Cars/UI/Pages/SellCar/SellCar.dart';
import 'package:Cars/backend/FirebaseBackend.dart';
import 'package:flutter/material.dart';
import 'package:Cars/UI/Pages/HomePage/AvailableCars.dart';
import 'package:Cars/UI/Pages/HomePage/HomePage.dart';
import 'package:Cars/UI/Pages/UserProfile/UserProfile.dart';
import 'package:Cars/UI/Pages/NotificationPage/NotificationPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var userReference = FirebaseFirestore.instance.collection("Users");

class BottomNavScreen extends StatefulWidget {
  String phoneNumber;

  BottomNavScreen({this.phoneNumber});
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  String userName;
  String image = "NULL";
  PageController pageController;
  int _currentIndex = 0;
  var user;
  getCurrentUser(String phoneNumber) async {
    String phoneNumbe =
        phoneNumber.substring(0, 3) + " " + phoneNumber.substring(3, 13);
    print(phoneNumbe);
    final DocumentSnapshot documentSnapshot =
        await userReference.doc(phoneNumber).get();
    setState(() {
      userName = documentSnapshot.data()["userName"];
      image = documentSnapshot.data()["Image"];
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    getCurrentUser(widget.phoneNumber);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          HomePage(
            phoneNumber: widget.phoneNumber,
            userName: userName,
            userPhoto: image == 'NULL'? "":image,
          ),
          AvailableCars(),
          SellCar(),
          NotificationPage(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => onTapFunction(index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drive_eta),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
              title: new Container(height: 5.0),
              icon: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).accentColor.withOpacity(0.4),
                      blurRadius: 40,
                      offset: Offset(0, 15),
                    ),
                    BoxShadow(
                      color: Theme.of(context).accentColor.withOpacity(0.4),
                      blurRadius: 13,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: new Icon(
                  (Icons.add),
                  color: Colors.white,
                ),
              )),
          BottomNavigationBarItem(
            icon: new Icon(Icons.notifications),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Container(height: 0.0),
          ),
        ],
      ),
    );
  }

  void onTapFunction(int index) {
    setState(() {
      _currentIndex = index;
      pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }
}
