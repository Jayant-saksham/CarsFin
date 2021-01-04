import 'package:flutter/material.dart';
import 'package:Cars/UI/Widgets/AppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Cars/UI/Widgets/circularProgress.dart';
import 'package:Cars/UI/Pages/HomePage/BookCar.dart';

var bookingReference = FirebaseFirestore.instance.collection("Bookings");

class Bookings extends StatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  int totalBookings = 0;
  List bookings = [];
  getAllBookings() async {
    bookingReference.get().then(
      (snapshot) {
        snapshot.docs.forEach((element) {
          setState(() {
            bookings.add(element.data());
          });
        });
      },
    );
  }

  @override
  void initState() {
    getAllBookings();
    print(bookings);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        title: "Bookings",
        isLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: bookingReference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: bookings.map((c) {
                  return ListTile(
                    // leading: CircleAvatar(
                    //   child: Image.network(c['Images'][0].toString()),
                    // ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          c['Car Number'].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                              Text(c['Car Brand'].toString()),
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
                              Text("Owner Contact"),
                              Text(c['Car Owner Number'].toString()),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text("Buyer Contact"),
                              Text(c['Phone Number'].toString()),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
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
}
