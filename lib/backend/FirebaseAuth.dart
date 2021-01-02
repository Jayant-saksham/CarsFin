import 'package:Cars/Models/Users.dart';
import 'package:Cars/UI/OnBoardScreen/OnBoardScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Cars/UI/BottomNavBar/BottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Users users;

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          String userName = "";
          String image = "";
          var user = FirebaseAuth.instance.currentUser;
          String userPhoneNumber = user.phoneNumber;
          userPhoneNumber = userPhoneNumber.substring(0, 3) +
              " " +
              userPhoneNumber.substring(3, 13);
          userReference.doc(userPhoneNumber).get().then((value) {
            userName = value.data()["userName"];
            print(userName);
          });

          return BottomNavScreen(
            name: userName,
            phoneNumber: userPhoneNumber,
          );
        } else {
          return OnBoardingScreen();
        }
      },
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authCredential) async {
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
