import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageHelper extends StatefulWidget {
  @override
  _ImageHelperState createState() => _ImageHelperState();
}

class _ImageHelperState extends State<ImageHelper> {
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
  @override
  Widget build(BuildContext context) {
    return Container(
 

    dialogBox(context) {
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
            children: [
              SimpleDialogOption(
                child: Text(
                  "Capture Image with Camera",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: captureWithCamera(),
              ),
              SimpleDialogOption(
                child: Text(
                  "Pick image from galary",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: pickImageFromGallery(),
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
      
    );
  }
}