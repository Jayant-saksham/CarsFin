import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'NamePage.dart';

class OTPScreenPage extends StatefulWidget {
  String phoneNumber;
  OTPScreenPage({@required this.phoneNumber});
  @override
  _OTPScreenPageState createState() => _OTPScreenPageState();
}

class _OTPScreenPageState extends State<OTPScreenPage> {
  String get _phoneNumber => widget.phoneNumber;
  TextEditingController _pinCodeController = TextEditingController();
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
              "${_phoneNumber.substring(0, 8)} ******",
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NamePage(userPhone: "9319970198")));
                  },
                  child: Text(
                    "Verify",
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                  inactiveColor: Colors.indigo,
                  activeColor: Colors.green),
              keyboardType: TextInputType.number,
              controller: _pinCodeController,
              appContext: context,
              length: 6,
              obscureText: true,
              autoDisposeControllers: false,
              onChanged: (pinCode) {
                print(pinCode);
              }),
          Text(
            "Enter your 6 digit code",
            style: TextStyle(color: Color(0xFF818181)),
          )
        ],
      ),
    );
  }
}
