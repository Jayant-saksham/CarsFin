import 'package:flutter/material.dart';
import 'package:Cars/UI/Widgets/AppBar.dart';
import 'package:Cars/Models/Brands.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Cars/UI/Widgets/circularProgress.dart';

var brandReference = FirebaseFirestore.instance.collection("Brands");

class AddBrand extends StatefulWidget {
  @override
  _AddBrandState createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  File brandImage;
  String filePath;
  String name;

  void captureWithCamera() async {
    Navigator.pop(context);
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      brandImage = File(pickedFile.path);
    });
  }

  void pickImageFromGallery() async {
    Navigator.pop(context);
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      brandImage = File(pickedFile.path);
    });
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

  List brands = [];
  getAllBrands() async {
    brandReference.get().then(
      (snapshot) {
        snapshot.docs.forEach(
          (element) {
            setState(() {
              brands.add(element.data());
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getAllBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        title: "Brands",
        isLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: brandReference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: brands.map((brand) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(brand["Image"]),
                    ),
                    subtitle: Text(brand["Deals"].toString()),
                    title: Text(brand["Brand"]),
                  );
                }).toList(),
              ),
            );
          } else {
            return circularProgress();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                child: Container(
                  height: 440,
                  width: 380,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.cancel),
                            color: Colors.black,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      Text(
                        "Add a Brand",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 60,
                            backgroundImage: brandImage == null
                                ? NetworkImage('')
                                : FileImage(brandImage),
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
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: _nameWidget(),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            color: Colors.green,
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Icon(Icons.add, color: Colors.white),
                                ],
                              ),
                            ),
                            onPressed: () async {
                              if (name == null || brandImage == null) {
                                Fluttertoast.showToast(
                                  msg: "Name and Image is required",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                Brand brand;
                                setState(() {
                                  brand = Brand(
                                    image: brandImage,
                                    name: name,
                                    offers: 0,
                                  );
                                });
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                                );
                                await addNewBrand(brand);
                                Navigator.pop(context);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        super.widget,
                                  ),
                                );
                              }
                            },
                          ),
                          MaterialButton(
                            color: Colors.orange,
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Icon(Icons.cancel, color: Colors.white),
                                ],
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> addNewBrand(Brand brand) async {
    final FirebaseStorage storage =
        FirebaseStorage(storageBucket: 'gs://carsfin-5a805.appspot.com');
    String imagePath = "Brands/Images/${brand.name}.png";
    String imageUrl;
    UploadTask uploadTask;
    uploadTask = storage.ref().child(imagePath).putFile(brand.image);
    var url = await (await uploadTask).ref.getDownloadURL();
    imageUrl = url.toString();

    await brandReference.doc(brand.name).set(
      {
        "Brand": brand.name,
        "Image": imageUrl,
        "Deals": brand.offers,
        "TimeStamp": DateTime.now(),
      },
    );
  }

  Widget _nameWidget() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value.isEmpty) {
          return 'Cannot be empty';
        }
      },
      onChanged: (value) {
        setState(
          () {
            name = value;
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
}
