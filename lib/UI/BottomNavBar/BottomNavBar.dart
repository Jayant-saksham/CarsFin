import 'package:Cars/UI/Pages/SellCar/SellCar.dart';
import 'package:flutter/material.dart';
import 'package:Cars/UI/Pages/HomePage/AvailableCars.dart';
import 'package:Cars/UI/Pages/HomePage/HomePage.dart';
import 'package:Cars/UI/Pages/UserProfile/UserProfile.dart';
import 'package:Cars/UI/Pages/NotificationPage/NotificationPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Cars/UI/Pages/NamePage/NamePage.dart';
// import 'package:Cars/UI/Pages/NamePage/AgencyName.dart';
import 'package:firebase_auth/firebase_auth.dart';

var userReference = FirebaseFirestore.instance.collection("Users");
var agencyReference = FirebaseFirestore.instance.collection("Agency");

class BottomNavScreen extends StatefulWidget {
  String phoneNumber;
  // bool isAgency;
  BottomNavScreen({
    this.phoneNumber,
  });
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  String userName;
  String image;
  PageController pageController;
  bool isExist = false;
  int _currentIndex = 0;
  var user;

  String phoneNo, verificationId, smsCode;
  Future<bool> checkIfUserExist(String phoneNumber) async {
    final DocumentSnapshot documentSnapshot =
        await userReference.doc(phoneNumber).get();
    if (documentSnapshot.exists) {
      setState(() {
        isExist = true;
        userName = documentSnapshot.data()["userName"];
        image = documentSnapshot.data()["Image"];
      });
    } else {
      setState(() {
        isExist = false;
      });
    }
    return isExist;
  }

  Future<bool> checkIfAgencyExist(String phoneNumber) async {
    final DocumentSnapshot documentSnapshot =
        await agencyReference.doc(phoneNumber).get();
    if (documentSnapshot.exists) {
      setState(() {
        isExist = true;
        userName = documentSnapshot.data()["Name"];
        image = documentSnapshot.data()["Image"];
      });
    } else {
      setState(() {
        isExist = false;
      });
    }
    return isExist;
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    checkIfUserExist(FirebaseAuth.instance.currentUser.phoneNumber).then(
      (user) {
        if (!user) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NamePage(
                userPhone: widget.phoneNumber,
              ),
            ),
          );
        }
      },
    );
    // !widget.isAgency
    //     ?
    //     : checkIfAgencyExist(FirebaseAuth.instance.currentUser.phoneNumber)
    //         .then(
    //         (agency) {
    //           if (!agency) {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => AgencyNamePage(
    //                   userPhone: phoneNo,
    //                 ),
    //               ),
    //             );
    //           }
    //         },
    //       );
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
            userPhoto: image,
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
