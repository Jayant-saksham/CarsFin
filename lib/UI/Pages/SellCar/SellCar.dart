import 'package:flutter/material.dart';
import 'package:Cars/UI/Widgets/AppBar.dart';
import 'SellCar2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Cars/UI/Widgets/circularProgress.dart';

var brandReference = FirebaseFirestore.instance.collection("Brands");

class SellCar extends StatefulWidget {
  @override
  _SellCarState createState() => _SellCarState();
}

class _SellCarState extends State<SellCar> {
  String carNum;
  String dmDriven;
  String carbrand;
  String modelNumber;
  List brands = [];
  getAllBrands() async {
    await brandReference.get().then(
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(
          title: "Sell a Car",
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () => chooseBrand(),
                  child: Text(
                    "Enter the details of your Car",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "All fields are compulsary",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Image.asset(
                'assets/images/sellCar.png',
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Step 1 of 4",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 10,
                ),
                child: carNumber(),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 10,
                ),
                child: kmDriven(),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 10,
                ),
                child: brand(),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 10,
                ),
                child: brandModelNumber(),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: Colors.indigo,
                  onPressed: () {
                    if (carbrand == null ||
                        carNum == null ||
                        dmDriven == null ||
                        modelNumber == null) {
                      Fluttertoast.showToast(
                        msg: "All Fields are compulsary",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SellCar2(
                            carBrand: carbrand,
                            carNumber: carNum,
                            kmDriven: dmDriven,
                            modelNumber: modelNumber,
                          ),
                        ),
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
    );
  }

  Widget carNumber() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Cannot be empty";
        }
      },
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
        hintText: "Enter Car Number - (DLASAA7783)",
        prefixIcon: Icon(Icons.drive_eta),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          carNum = value.toUpperCase();
        });
      },
    );
  }

  Widget brand() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Cannot be empty";
        }
      },
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: "Enter Car's brand",
        prefixIcon: Icon(Icons.speed),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          carbrand = value.toString();
        });
      },
    );
  }

  Widget brandModelNumber() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Cannot be empty";
        }
      },
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: "Enter Car's Model Number",
        prefixIcon: Icon(Icons.speed),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          modelNumber = value;
        });
      },
    );
  }

  Widget kmDriven() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Cannot be empty";
        }
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Enter Car Driven (in KM)",
        prefixIcon: Icon(
          Icons.drive_eta,
        ),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          dmDriven = value.toString().trim();
        });
      },
    );
  }

  Widget chooseBrand() {
    return StreamBuilder(
      stream: brandReference.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Dialog(
            child: Container(
              child: ListView(
                children: brands.map((brand) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        brand["Image"],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return circularProgress();
        }
      },
    );
  }
}
