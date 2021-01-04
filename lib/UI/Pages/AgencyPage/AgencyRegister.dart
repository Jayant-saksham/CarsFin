import 'package:Cars/UI/Pages/UserLogin/LoginOTP.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Cars/backend/FirebaseAuth.dart';
import 'package:Cars/UI/Pages/OTPPage/OTPScreenPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Cars/UI/Pages/UserLogin/UserLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var userReference = FirebaseFirestore.instance.collection("Users");
bool isExist;

class AgencyRegister extends StatefulWidget {
  @override
  _AgencyRegisterState createState() => _AgencyRegisterState();
}

class _AgencyRegisterState extends State<AgencyRegister> {
  TextEditingController _phoneAuthController = TextEditingController();
  static Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode("91");
  bool codeSent = false;
  String phoneNo, verificationId, smsCode;

  String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  String name;
  @override
  void dispose() {
    _phoneAuthController.dispose();
    super.dispose();
  }

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
    return SafeArea(
      child: Scaffold(
        body: _bodyWidget(),
      ),
    );
  }

  Widget _bodyWidget() {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 5,
            ),
            Text(
              "Agency Register",
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
            ListTile(
              onTap: _openFilteredCountryPickerDialog,
              title: _buildDialogItem(
                _selectedFilteredDialogCountry,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 25,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  width: 80,
                  height: 42,
                  alignment: Alignment.center,
                  child: Text(
                    "${_selectedFilteredDialogCountry.phoneCode}",
                    style: TextStyle(
                      color: Color(0xFF818181),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          phoneNo = "+" + _countryCode + " " + value.trim();
                        });
                      },
                      keyboardType: TextInputType.phone,
                      controller: _phoneAuthController,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        hintStyle: TextStyle(
                          color: Color(0xFF818181),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: Colors.indigo,
                  onPressed: () async {
                    await checkIfUserExist(phoneNo);
                    if (isExist) {
                      Fluttertoast.showToast(
                        msg: "Agency exist",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      await verifyPhone2(phoneNo);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginOTP(
                            phoneNumber: phoneNo,
                            verificationID: verificationId,
                          ),
                        ),
                      );
                    } else {
                      await verifyPhone(phoneNo);
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Already a User?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserLogin(),
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openFilteredCountryPickerDialog() {
    showDialog(
      context: context,
      child: CountryPickerDialog(
        titlePadding: EdgeInsets.all(1),
        title: Text("Select your country"),
        searchInputDecoration: InputDecoration(
          hintText: "Seach",
        ),
        isSearchable: true,
        onValuePicked: (Country country) {
          setState(
            () {
              _selectedFilteredDialogCountry = country;
              _countryCode = country.phoneCode;
            },
          );
        },
        itemBuilder: _buildDialogItem,
      ),
    );
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            height: 8,
          ),
          Text(
            " + ${country.phoneCode}",
            style: TextStyle(color: Color(0xFF818181)),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            " ${country.name}",
            style: TextStyle(
              color: Color(0xFF818181),
            ),
          ),
          Spacer(),
          Icon(
            Icons.keyboard_arrow_down,
          )
        ],
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
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
          builder: (context) => OTPScreenPage(
            phoneNumber: phoneNo,
            verificationID: verificationId,
          ),
        ),
      );
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(
        seconds: 30,
      ),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }

  Future<void> verifyPhone2(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
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
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(
        seconds: 30,
      ),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }
}
