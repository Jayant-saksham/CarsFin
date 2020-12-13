import 'package:Cars/Pages/HomePage.dart';
import 'package:Cars/Pages/UploadCarPage.dart';
import 'package:Cars/Pages/ProfilePage.dart';
import 'package:Cars/Pages/WishList.dart';
import 'package:Cars/Services/Camera.dart';
import 'package:Cars/Themes/constants.dart';
import 'package:Cars/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class BottomNavScreen extends StatefulWidget {
  List<CameraDescription> cameras;
  BottomNavScreen({this.cameras});
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  

  final List _screens = [
    HomePage(
      userName: "Jayant",
    ),
    // CameraScreen(cameras),
    WishListPage(),
    UploadCarPage(),
    Scaffold(),
    Scaffold(),
  ];
  int _currentIndex = 0;
  String _locationMessage;
  void _getCurrentLocation() async {
    print("Tesing");
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
            icon: Icon(Icons.location_on),
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
                        offset: Offset(0, 15)),
                    BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 13,
                        offset: Offset(0, 3))
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
}
