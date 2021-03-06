import 'dart:io';
import 'package:Cars/UI/BottomNavBar/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Cars/backend/FirebaseBackend.dart';
import 'package:Cars/Models/Users.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Cars/Models/Agency.dart';

Users user;

class AgencyNamePage extends StatefulWidget {
  String userPhone;
  AgencyNamePage({@required this.userPhone});
  @override
  _AgencyNamePageState createState() => _AgencyNamePageState();
}

class _AgencyNamePageState extends State<AgencyNamePage> {
  String get phoneNumber => widget.userPhone;
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  String userName;
  File userImage;
  String filePath;
  var agency;
  String email;

  void captureWithCamera() async {
    Navigator.pop(context);
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    setState(
      () {
        userImage = File(pickedFile.path);
      },
    );
  }

  void pickImageFromGallery() async {
    Navigator.pop(context);
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(
      () {
        userImage = File(pickedFile.path);
      },
    );
  }

  Future<void> dialogBox(context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: new Text(
            "Choose a photo",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            SimpleDialogOption(
              child: Text(
                "Pick image from galary",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: pickImageFromGallery,
            ),
            SimpleDialogOption(
              child: Text(
                "Capture Image with Camera",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: captureWithCamera,
            ),
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Profile Info",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Please provide your name ",
                  style: TextStyle(
                    color: Color(0xFF818181),
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: MediaQuery.of(context).size.width / 4.8,
                      backgroundImage: userImage == null
                          ? NetworkImage('')
                          : FileImage(userImage),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.teal,
                        size: 30,
                      ),
                      onPressed: () {
                        dialogBox(context);
                      },
                    )
                  ],
                ),
                
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: _nameWidget(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: _enterEmail(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    color: Colors.indigo,
                    onPressed: () async {
                      if (userImage == null ||
                          userName == null ||
                          email == null) {
                        Fluttertoast.showToast(
                          msg: "All fields are compulsary",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else {
                        setState(() {
                          agency = Agency(
                            agencyEmail: email,
                            agencyName: userName,
                            images: userImage,
                            agencyPhoneNumber: widget.userPhone,
                          );
                        });
                        await FirebaseFunctions().createAgency(agency);
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavScreen(
                              phoneNumber: user.phoneNumber,
                              // isAgency: true,
                            ),
                          ),
                          (route) => false,
                        );
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameWidget() {
    return TextFormField(
      key: _nameKey,
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value.isEmpty) {
          return 'Cannot be empty';
        }
      },
      onChanged: (value) {
        setState(
          () {
            userName = value;
          },
        );
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        labelText: 'Name',
      ),
    );
  }

  Widget _enterEmail() {
    return TextFormField(
      key: _nameKey,
      validator: (value) {
        if (value.isEmpty) {
          return 'Cannot be empty';
        }
      },
      onChanged: (value) {
        setState(
          () {
            email = value;
          },
        );
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        labelText: 'Email',
      ),
    );
  }
}
