import 'package:Cars/Pages/Registerpage.dart';
import 'package:flutter/material.dart';
import 'package:Cars/Pages/AgencySplashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    var firebase = FirebaseFirestore.instance.collection("Users").get();
    print(firebase);
    super.initState();
  }

  void validate() {
    if (_formKey.currentState.validate()) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AgencySplashScreen()));
      print("Done");
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String phoneNumber;
  String verificationId, smsCode;
  bool codeSent = false;
  String userName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                Image.network(
                    'https://assets.stickpng.com/images/580b585b2edbce24c47b2c18.png',
                    width: MediaQuery.of(context).size.width * 0.5),
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
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: _enterEmail(),
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
                      onTap: () => validate(),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.amber[600],
                        ),
                        height: 36,
                        width: MediaQuery.of(context).size.width * 0.46,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                      "Don't have an account ?",
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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

  Widget _enterEmail() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          icon: Icon(Icons.email),
          labelText: 'Email',
          border: OutlineInputBorder()),
      validator: (value) {
        if (value.isEmpty) {
          return 'Number is required';
        }
        if (!value.contains(".") && !value.contains("@")) {
          return "Invalid email";
        }
      },
      onChanged: (value) {
        setState(() {
          this.phoneNumber = value;
          this.phoneNumber = "+91 " + phoneNumber;
        });
      },
    );
  }

  Widget _enterPhoneNumber() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty) {
          return ("Cannot be empty");
        }
        if (value.length != 10) {
          return "Invalid Phone Number";
        }
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        icon: Icon(Icons.phone),
        labelText: "Phone",
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          phoneNumber = value;
        });
      },
    );
  }
}
