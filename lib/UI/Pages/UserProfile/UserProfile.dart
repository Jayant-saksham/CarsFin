import 'package:flutter/material.dart';
import 'Clipper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Cars/UI/Widgets/circularProgress.dart';

var userReference = FirebaseFirestore.instance.collection("Users");

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName;
  String image;
  bool isExist = false;
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

  @override
  void initState() {
    checkIfUserExist(FirebaseAuth.instance.currentUser.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              color: Colors.black.withOpacity(0.8),
            ),
            clipper: getClipper(),
          ),
          Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(130),
                  child: image == null
                      ? circularProgress()
                      : Image(
                          image: NetworkImage(
                            image == null ? "" : image,
                          ),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(height: 90.0),
                Text(
                  userName == null ? "User" : userName,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  FirebaseAuth.instance.currentUser.phoneNumber,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                // Icon(Icons.location_on),
                // SizedBox(
                //   width: 5,
                // ),
                // Text(
                //   'Burari, Delhi, India',
                //   style: TextStyle(
                //     fontSize: 17.0,
                //     fontStyle: FontStyle.italic,
                //   ),
                // ),
                //   ],
                // ),
                // SizedBox(height: 25.0),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Icon(Icons.phone),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     Text(
                //       '+91 9319970198',
                //       style: TextStyle(
                //         fontSize: 17.0,
                //         fontStyle: FontStyle.italic,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 90.0,
                      width: 120.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.redAccent,
                        color: Colors.orange,
                        elevation: 7.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Cars Sold',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 29,
                    ),
                    Container(
                      height: 90.0,
                      width: 120.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.redAccent,
                        color: Colors.pink,
                        elevation: 7.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Cars Buy',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
