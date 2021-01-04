import 'package:Cars/UI/Pages/UserLogin/LoginOTP.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Cars/backend/FirebaseAuth.dart';
import 'package:Cars/backend/FirebaseBackend.dart';
import 'package:Cars/UI/BottomNavBar/BottomNavBar.dart';

bool isExist;

var userReference = FirebaseFirestore.instance.collection("Users");

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  bool codeSent = false;
  String name;
  String phoneNo, verificationId, smsCode;
  Future checkIfUserExist(String phoneNumber) async {
    final DocumentSnapshot documentSnapshot =
        await userReference.doc(phoneNumber).get();
    if (documentSnapshot.exists) {
      setState(() {
        isExist = true;
        name = documentSnapshot.data()["userName"];
      });
    } else {
      setState(() {
        isExist = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Image.asset(
                  "assets/images/user.png",
                  width: 160,
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: Text(
                    "Please Sign in to continue ",
                    style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 9),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: _enterPhoneNumber(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: MaterialButton(
                    color: Colors.indigo,
                    child: Text(
                      "Verify",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await checkIfUserExist(phoneNo);
                      if (isExist) {
                        Fluttertoast.showToast(
                          msg: "User exist",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        verifyPhone(phoneNo);
                        // Navigator.pop(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => LoginOTP(
                        //         phoneNumber: phoneNo,
                        //         verificationID: verificationId,
                        //         name: name,
                        //       ),
                        //     ));
                      } else {
                        Fluttertoast.showToast(
                          msg: "User does not exist",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),

                  // child: InkWell(
                  //   onTap: () {
                  // checkIfUserExist(phoneNo);
                  // if (isExist) {
                  //   Fluttertoast.showToast(
                  //     msg: "User exist",
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.CENTER,
                  //     timeInSecForIosWeb: 1,
                  //     backgroundColor: Colors.black,
                  //     textColor: Colors.white,
                  //     fontSize: 16.0,
                  //   );
                  //   verifyPhone(phoneNo);
                  // } else {
                  //   Fluttertoast.showToast(
                  //     msg: "User does not exist",
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.CENTER,
                  //     timeInSecForIosWeb: 1,
                  //     backgroundColor: Colors.black,
                  //     textColor: Colors.white,
                  //     fontSize: 16.0,
                  //   );
                  //   Navigator.pop(context);
                  // }
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(15),
                  //       ),
                  //       color: Colors.amber[600],
                  //     ),
                  //     height: 36,
                  //     width: MediaQuery.of(context).size.width * 0.46,
                  //     child: Center(
                  //       child: codeSent
                  //           ? Text(
                  //               "Login",
                  //               style: TextStyle(
                  //                 fontSize: 20,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             )
                  //           : Text(
                  //               "Verify",
                  //               style: TextStyle(
                  //                 fontSize: 20,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //     ),
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _enterOTP() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        labelText: 'OTP',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Number is required';
        }
      },
      onChanged: (value) {
        setState(() {
          smsCode = value;
        });
      },
    );
  }

  Widget _enterPhoneNumber() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value.isEmpty) {
          return ("Cannot be empty");
        }
      },
      decoration: InputDecoration(
        icon: Icon(Icons.phone),
        labelText: "Phone Number",
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          phoneNo = "+91" + " " + value.trim();
        });
      },
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      AuthService().signIn(authResult);
      // Navigator.pop(context);
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => BottomNavScreen(
      //       name: name,
      //       phoneNumber: phoneNo,
      //     ),
      //   ),
      //   (route) => false,
      // );
    };

    final PhoneVerificationFailed verificationfailed = (authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) async {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
      await Fluttertoast.showToast(
        msg: "OTP send",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginOTP(
            phoneNumber: phoneNo,
            verificationID: verificationId,
            name: name,
          ),
        ),
      );
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 30),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }
}
