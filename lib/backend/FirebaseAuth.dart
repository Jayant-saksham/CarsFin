import 'package:Cars/Models/Users.dart';
import 'package:Cars/UI/OnBoardScreen/OnBoardScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Cars/UI/BottomNavBar/BottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var userReference = FirebaseFirestore.instance.collection("Users");

Users users;
bool isExist = false;
String name;

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return BottomNavScreen(
            phoneNumber: firebaseAuth.currentUser.phoneNumber,
            // isAgency: false,
          );
        } else {
          return OnBoardingScreen();
        }
      },
    );
  }

  checkIfUserExist(String phoneNumber) async {
    final DocumentSnapshot documentSnapshot =
        await userReference.doc(phoneNumber).get();
    if (documentSnapshot.exists) {
      isExist = true;
      name = documentSnapshot.data()["userName"];
    }
  }

  Future signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authCredential) async {
    await FirebaseAuth.instance.signInWithCredential(authCredential);
  }

  signInWithOTP(smsCode, verificationID) {
    AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verificationID,
      smsCode: smsCode,
    );
    signIn(authCredential);
    // return firebaseAuth.currentUser.uid;
  }
}
