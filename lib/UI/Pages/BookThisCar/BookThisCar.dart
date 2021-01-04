import 'package:flutter/material.dart';
import 'package:Cars/UI/Widgets/AppBar.dart';
import 'package:Cars/Models/Cars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Cars/backend/FirebaseBackend.dart';
import 'Confirmation.dart';

class BookThisCar extends StatefulWidget {
  Car car;
  BookThisCar({@required this.car});
  @override
  _BookThisCarState createState() => _BookThisCarState();
}

class _BookThisCarState extends State<BookThisCar> {
  String email;
  String phoneNumber;
  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: widget.car.model + "  " + widget.car.brand),
      backgroundColor: Colors.white,
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
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: Text(
                    "Book Car",
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
                    "Please provide your details ",
                    style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 9),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: _enterName(),
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
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: _enterPhoneNumber(),
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
                        if (name == null ||
                            email == null ||
                            phoneNumber == null) {
                          Fluttertoast.showToast(
                            msg: "All field are compulsary",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          FirebaseFunctions().bookCar(
                            widget.car,
                            email,
                            phoneNumber,
                            name,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Confirmation(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.amber[600],
                        ),
                        height: 36,
                        width: MediaQuery.of(context).size.width * 0.46,
                        child: Center(
                          child: Text(
                            "Book",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _enterName() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          icon: Icon(Icons.person),
          labelText: 'Name',
          border: OutlineInputBorder()),
      validator: (value) {
        if (value.isEmpty) {
          return 'Number is required';
        }
      },
      onChanged: (value) {
        setState(() {
          name = value.trim();
        });
      },
    );
  }

  Widget _enterEmail() {
    return TextFormField(
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
          email = value.trim();
        });
      },
    );
  }

  Widget _enterPhoneNumber() {
    return TextFormField(
      // textInputAction: TextInputAction.next,
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
        setState(
          () {
            phoneNumber = value.trim();
          },
        );
      },
    );
  }
}
