import 'dart:io';
import 'package:flutter/material.dart';
import 'package:Cars/Pages/HomePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class NamePage extends StatefulWidget {
  String userPhone;
  NamePage({@required this.userPhone});
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

  String userName;
  String userEmail;
  File userImage;
  String filePath;

  void getImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      filePath = pickedFile.path;
      userImage = File(pickedFile.path);
    });
  }

  Future<void> createRecord() async {
    var firebaseStorageRef =
        await FirebaseStorage.instance.ref().child("Users/Images");

    var response = await FirebaseFirestore.instance
        .collection("Users")
        .doc(userName + widget.userPhone)
        .set({
      "userName": userName,
      "userNumber": widget.userPhone,
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    });
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
                      fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Please provide your name ",
                  style: TextStyle(color: Color(0xFF818181), fontSize: 18),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Stack(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: MediaQuery.of(context).size.width / 4.8,
                        backgroundImage:
                            userImage == null ? null : FileImage(userImage)),
                    IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.teal,
                          size: 30,
                        ),
                        onPressed: () {
                          getImage();
                        })
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: _nameWidget()),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
               
                
                Align(
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
                      "Next",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )
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
        setState(() {
          userName = value;
        });
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        labelText: 'Name',
      ),
    );
  }


}
