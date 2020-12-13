import 'package:Cars/Pages/NamePage.dart';
import 'package:Cars/Pages/LoginPage.dart';

import 'package:Cars/Pages/OTPScreenPage.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Cars/Services/PhoneAuth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String phoneNumber;
  var verificationId, smsCode;
  bool codeSent = false;
  String countryCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: Text(
                    "CarsFin will send a OTP to verify",
                    style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    "your phone number",
                    style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 9),
                Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: countriesCode()),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: _buildPhoneNumber(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    child: InkWell(
                      onTap: () {
                        codeSent
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OTPScreenPage(
                                          smsCode: smsCode,
                                          verificationId: verificationId,
                                          phoneNumber: phoneNumber,
                                        )))
                            : verifyPhone(phoneNumber);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.amber[600],
                        ),
                        height: 36,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Center(
                          child: Center(
                            child: codeSent
                                ? Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "Verify",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text("Sign In",
                          style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
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

  Widget _buildPhoneNumber() {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          icon: Icon(Icons.phone),
          labelText: 'Phone Number',
          border: OutlineInputBorder()),
      validator: (value) {
        if (value.isEmpty) {
          return 'Phone is Required';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          phoneNumber = value;
          phoneNumber = countryCode + " " + phoneNumber;
        });
        print(phoneNumber);
      },
    );
  }

  Widget _enterOtP() {
    return TextFormField(
      obscureText: true,
      validator: (value) {
        if (value.isEmpty) {
          return "Cannot be empty";
        }
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        labelText: 'OTP',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          smsCode = value;
        });
      },
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService(phoneNumber: phoneNumber).signIn(authResult);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NamePage(
                    userPhone: phoneNumber,
                  )));
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      Fluttertoast.showToast(
          msg: "OTP sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        this.codeSent = true;
      });
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  Widget countriesCode() {
    return CountryCodePicker(
      enabled: true,
      showCountryOnly: true,
      onInit: (value) {
        countryCode = value.dialCode.toString();
      },
      onChanged: (value) => setState(() {
        countryCode = value.dialCode.toString();
      }),
      initialSelection: 'IN',
      favorite: ['+91', 'IN'],
      alignLeft: false,
    );
  }
}
