import 'package:Cars/Models/Users.dart';
import 'package:Cars/UI/OnBoardScreen/OnBoardScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Cars/UI/BottomNavBar/BottomNavBar.dart';
import 'package:Cars/UI/Pages/PhoneRegister/Register.dart';
import 'package:Cars/UI/Pages/NamePage/NamePage.dart';
import 'FirebaseBackend.dart';

Users users;

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return BottomNavScreen();
        } else {
          return OnBoardingScreen();
        }
      },
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(
    AuthCredential authCredential,
  ) async {
    await FirebaseAuth.instance.signInWithCredential(authCredential);
  }
  

  void signInWithOTP(smsCode, verificationID) {
    AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verificationID,
      smsCode: smsCode,
    );
    signIn(authCredential);
  }
}
