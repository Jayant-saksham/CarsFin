import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadCarPage extends StatefulWidget {
  @override
  _UploadCarPageState createState() => _UploadCarPageState();
}

class _UploadCarPageState extends State<UploadCarPage> {
  File userImage;
  captureWithCamera() async {
    Navigator.pop(context);
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      userImage = File(pickedFile.path);
    });
  }

  pickImageFromGallery() async {
    Navigator.pop(context);
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      userImage = File(pickedFile.path);
    });
  }

  Future<void> dialogBox(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: new Text(
              "Sell Car",
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(right: 10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Text(
                  "Sell a Car",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 46,
                ),
                Text("Enter your Car details",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 46,
                ),
                carNumber()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget carNumber() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          fillColor: Colors.grey[100],
          hintText: "Enter your car number",
          icon: Icon(Icons.email),
          suffixIcon: Icon(Icons.arrow_forward_ios),
          labelText: 'Car Number',
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
          print(value);
        });
      },
    );
  }
}
