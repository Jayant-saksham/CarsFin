import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Cars/UI/BottomNavBar/BottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var agencyReference = FirebaseFirestore.instance.collection("Agency");

class AgencyLogin extends StatefulWidget {
  @override
  _AgencyLoginState createState() => _AgencyLoginState();
}

class _AgencyLoginState extends State<AgencyLogin> {
  String phoneNumber;
  String verificationCode;

  TextEditingController otpController;
  TextEditingController phoneController;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String verificationId;
  bool codeSent = false;

  @override
  void initState() {
    otpController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      verificationId = verId;
      setState(() {
        codeSent = true;
      });
      Fluttertoast.showToast(
        msg: "OTP send",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      firebaseAuth.signInWithCredential(auth).then((value) {
        if (value.user != null) {
          User user = value.user;
          userAuthorized();
        } else {
          debugPrint('user not authorized');
        }
      }).catchError((error) {
        debugPrint('error : $error');
      });
    };

    final PhoneVerificationFailed veriFailed = (exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 30),
      verificationCompleted: verifiedSuccess,
      verificationFailed: veriFailed,
    );
  }

  void verifyOTP(String smsCode) async {
    var _authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
    firebaseAuth.signInWithCredential(_authCredential).then((result) {
      User user = result.user;

      if (user != null) {
        userAuthorized();
      }

      ///go To Next Page
    }).catchError((error) {
      Navigator.pop(context);
    });
  }

  userAuthorized() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavScreen(
          phoneNumber: phoneController.text,
          // isAgency: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Register",
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 20,
            ),
            Text(
              "CarsFin will send a OTP to verify ",
              style: TextStyle(
                color: Color(0xFF818181),
                fontSize: 18,
              ),
            ),
            Text(
              "your Phone number",
              style: TextStyle(
                color: Color(0xFF818181),
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 8,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: InputDecoration(hintText: 'Enter phone Number'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter OTP'),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            codeSent
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: MaterialButton(
                      color: Colors.indigo,
                      onPressed: () => verifyOTP(otpController.text.trim()),
                      child: Center(
                        child: Text(
                          "Verify",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: MaterialButton(
                      color: Colors.indigo,
                      onPressed: () =>
                          verifyPhone("+91 " + phoneController.text.trim()),
                      child: Center(
                        child: Text(
                          "Send OTP",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
