import 'package:Cars/UI/Pages/NamePage/NamePage.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:Cars/backend/FirebaseAuth.dart';

class OTPScreenPage extends StatefulWidget {
  String phoneNumber;
  String verificationID;
  OTPScreenPage({
    @required this.phoneNumber,
    @required this.verificationID,
  });
  @override
  _OTPScreenPageState createState() => _OTPScreenPageState();
}

class _OTPScreenPageState extends State<OTPScreenPage> {
  String smsCode;
  TextEditingController _pinCodeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _pinCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 5,
            ),
            Text(
              "OTP Verification",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 20,
            ),
            Text(
              "CarsFin sent your code to ",
              style: TextStyle(color: Color(0xFF818181), fontSize: 18),
            ),
            Text(
              "${widget.phoneNumber.substring(0, 8)} ******",
              style: TextStyle(color: Color(0xFF818181), fontSize: 18),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 5,
            ),
            _phoneCodeWidget(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: Colors.indigo,
                  onPressed: () {
                    AuthService().signInWithOTP(smsCode, widget.verificationID);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NamePage(
                          userPhone: widget.phoneNumber.toString(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Verify",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _phoneCodeWidget() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 50,
      ),
      child: Column(
        children: [
          PinCodeTextField(
            onChanged: (pin) {
              print(pin);
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              inactiveColor: Colors.indigo,
              activeColor: Colors.green,
            ),
            keyboardType: TextInputType.number,
            controller: _pinCodeController,
            appContext: context,
            length: 6,
            obscureText: true,
            autoDisposeControllers: false,
            onCompleted: (pin) {
              setState(() {
                smsCode = pin;
              });
            },
          ),
          Text(
            "Enter your 6 digit code",
            style: TextStyle(
              color: Color(0xFF818181),
            ),
          )
        ],
      ),
    );
  }
}
