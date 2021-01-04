import 'package:Cars/UI/Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Cars/UI/Widgets/circularProgress.dart';

var userReference = FirebaseFirestore.instance.collection("Users");
var carReference = FirebaseFirestore.instance.collection("Cars");

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  List cars = [];
  getAllCars() async {
    carReference.get().then(
      (snapshot) {
        snapshot.docs.forEach((element) {
          setState(() {
            cars.add(element.data());
          });
        });
      },
    );
  }

  void initState() {
    getAllCars();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Car Request",
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
        stream: carReference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: cars.map((c) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Image.network(c['Images'][0].toString()),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          c['Car Number'].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        c['Has Insurance']
                            ? Text(
                                "I",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              )
                            : Text(""),
                        c['Has RC']
                            ? Text(
                                "R",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              )
                            : Text(""),
                        c['Has Pollution']
                            ? Text(
                                "P",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                              )
                            : Text(""),
                      ],
                    ),
                    subtitle: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("Brand"),
                              Text(c['Car brand'].toString()),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text("Model"),
                              Text(
                                c['Car Model'].toString(),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text("Price"),
                              Text(c['Price'].toString()),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text("Contact"),
                              Text(c['Dealer PhoneNumber'].toString()),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        c['Is Approved']
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        approveCar(c['Car Number'].toString());
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            return circularProgress();
          }
        },
      ),
    );
  }

  void approveCar(carNumber) async {
    int approvedCars;
    var response = await FirebaseFirestore.instance;
    response.collection("Cars").doc(carNumber).update(
      {
        "Is Approved": true,
      },
    );
    response.collection("Admin").doc("Admin").get().then((value) {
      setState(() {
        approvedCars = value.data()["Cars Approved"];
      });
    });
    response.collection("Admin").doc("Admin").update(
      {
        "Cars Approved": approvedCars,
      },
    );
  }
}
