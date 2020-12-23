import 'package:Cars/Models/Cars.dart';
import 'package:Cars/UI/Pages/HomePage/CarBoxBig.dart';
import 'package:Cars/UI/Widgets/AppBar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'BookCar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var carReference = FirebaseFirestore.instance.collection("Cars");

class AvailableCars extends StatefulWidget {
  @override
  _AvailableCarsState createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {
  List<Car> cars = [];
  List allCars = [];
  int carsLength = 0;

  getAllCars() async {
    carReference.get().then((snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          if (element.data()["Is Approved"]) {
            Car newCar = Car(
              brand: element.data()["Car brand"],
              dealerName: element.data()["Dealer Name"],
              dealerPhoneNumber: element.data()["Dealer PhoneNumber"],
              hasInsurance: element.data()["Has Insurance"],
              hasPollution: element.data()["Has Pollution"],
              images: element.data()["Images"],
              isApproved: element.data()["Is Approved"],
              isAvailable: true,
              kmDriven: element.data()["KM Driven"],
              model: element.data()["Car Model"],
              price: element.data()["Price"],
              carNumber: element.data()["Car Number"],
              milage: element.data()["Milage"],
              seats: element.data()["Seats"],
              location: element.data()["Location"],
              sellerEmail: element.data()["Dealer Email"],
            );
            cars.add(newCar);
            carsLength++;
          }
        });
      });
    });
  }

  @override
  void initState() {
    getAllCars();
    print(carsLength);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Available Cars  " + carsLength.toString(),
        isLeading: true,
        isAction: true,
        action: IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: HexColor('#F8FAFB'),
      body: carsLength == 0
          ? Center(
              child: Text("No Cars Available"),
            )
          : ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: cars.map((item) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookCar(car: item),
                      ),
                    );
                  },
                  child: carAdLong(item, 0),
                );
              }).toList(),
            ),
    );
  }

  List<Widget> buildcarLong() {
    List<Widget> list = [];
    for (int i = 0; i < cars.length; i++) {
      cars[i].isApproved
          ? list.add(
              carAdLong(cars[i], context),
            )
          : i++;
    }
    return list;
  }
}
