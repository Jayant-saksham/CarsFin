import 'package:Cars/Models/Cars.dart';
import 'package:Cars/Themes/constants.dart';
import 'package:Cars/UI/Widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'AvailableCars.dart';
import 'CarBoxBig.dart';
import 'package:hexcolor/hexcolor.dart';
import 'CarBoxShort.dart';
import 'package:Cars/UI/Widgets/AppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'BookCar.dart';
import './DealerWidget.dart';
import 'package:Cars/Models/Brands.dart';
import 'package:Cars/UI/Pages/AllBrands/AllBrands.dart';

var carReference = FirebaseFirestore.instance.collection("Cars");
var brandReference = FirebaseFirestore.instance.collection("Brands");

class HomePage extends StatefulWidget {
  String userName;
  String phoneNumber;
  String userPhoto;
  HomePage({
    this.userName,
    this.phoneNumber,
    this.userPhoto,
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String get userName => widget.userName;
  String get phoneNumber => widget.phoneNumber;
  // String get userImage => widget.userPhoto;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  List<Car> cars = [];
  List allCars = [];
  int carsLength = 0;

  void getAllCars() async {
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
              hasRC: element.data()["Has RC"],
            );
            cars.add(newCar);
            carsLength++;
          }
        });
      });
    });
  }

  List<Brand> brands = [];
  getAllBrands() async {
    brandReference.get().then(
      (snapshot) {
        snapshot.docs.forEach(
          (element) {
            Brand newBrand;
            setState(() {
              // brands.add(element.data());
              newBrand = Brand(
                  imageUrl: element.data()["Image"],
                  name: element.data()["Brand"],
                  offers: element.data()["Deals"]);
              brands.add(newBrand);
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    getAllCars();
    getAllBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: drawerKey,
      appBar: appBar(
        title: "CarsFin",
        isLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => drawerKey.currentState.openDrawer(),
        ),
      ),
      drawer: myDrawer(
        userName,
        phoneNumber.toString(),
        widget.userPhoto,
        context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                ),
                child: Text(
                  "Explore Cars",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor('#F8FAFB'),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Top Deals",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AvailableCars(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "View all",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 2.6,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: buildDeals(),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AvailableCars(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 16, left: 16),
                            child: SingleChildScrollView(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                padding: EdgeInsets.all(24),
                                height: MediaQuery.of(context).size.height / 7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Available Cars",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "Explore Variety of Cars",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      height: 50,
                                      width: 50,
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Top Brands",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllBrands(),
                                      ),
                                    ),
                                    child: Text(
                                      "View all",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          margin: EdgeInsets.only(bottom: 16),
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: buildDealers(),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildDealers() {
    List<Widget> list = [];
    for (var i = 0; i < brands.length; i++) {
      list.add(buildDealer(brands[i], i));
    }
    return list;
  }

  List<Widget> buildDeals() {
    List<Widget> list = [];
    for (var i = 0; i < cars.length; i++) {
      list.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookCar(
                  car: cars[i],
                ),
              ),
            );
          },
          child: buildCar(cars[i], i),
        ),
      );
    }
    return list;
  }

  List<Widget> buildcarLong() {
    List<Widget> list = [];
    for (int i = 0; i < cars.length; i++) {
      list.add(
        carAdLong(cars[i], context),
      );
    }
    return list;
  }
}
