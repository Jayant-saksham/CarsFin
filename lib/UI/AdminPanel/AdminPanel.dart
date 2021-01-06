import 'package:Cars/UI/Pages/NamePage/NamePage.dart';
import 'package:flutter/material.dart';
import 'package:Cars/UI/Widgets/AppBar.dart';
import 'AdminWidgets/CardWidget.dart';
import 'AdminWidgets/AdminDrawer.dart';
import 'AdminSubpages/Settings.dart';
import 'package:Cars/backend/FirebaseAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AdminSubpages/Users.dart';
import 'AdminSubpages/Cars.dart';

String imageUrl =
    'https://scontent.fdel5-1.fna.fbcdn.net/v/t1.0-9/480128_4549413205633_620077564_n.jpg?_nc_cat=110&ccb=2&_nc_sid=de6eea&_nc_ohc=g2eXmmK70kAAX8F5J6A&_nc_ht=scontent.fdel5-1.fna&oh=193ce9613936ce743efebab7d0b200e5&oe=60013BFF';
GlobalKey<ScaffoldState> drawerKey = GlobalKey();
AdminFirebase adminFirebase;
var userReference = FirebaseFirestore.instance.collection("Users");
var carReference = FirebaseFirestore.instance.collection("Cars");
var agencyReference = FirebaseFirestore.instance.collection("Agency");
var adminReference = FirebaseFirestore.instance.collection("Admin");

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int countUsers = 0;
  int countCar = 0;
  int countAgency = 0;
  int carsApproved = 0;
  countCars() async {
    carReference.get().then(
      (snapshot) {
        snapshot.docs.forEach(
          (element) {
            setState(() {
              countCar++;
            });
          },
        );
      },
    );
  }

  totalCarsApproved() async {
    adminReference.get().then((snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          carsApproved = element.data()['Cars Approved'];
        });
      });
    });
  }

  countUser() async {
    userReference.get().then(
      (snapshot) {
        snapshot.docs.forEach(
          (element) {
            setState(() {
              countUsers++;
            });
          },
        );
      },
    );
  }

  countAgencies() async {
    agencyReference.get().then((snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          countAgency++;
        });
      });
    });
  }

  @override
  void initState() {
    totalCarsApproved();
    countUser();
    countCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      backgroundColor: Colors.white,
      appBar: appBar(
        isAction: true,
        action: IconButton(
          icon: Icon(Icons.settings),
          color: Colors.black,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Setting(),
            ),
          ),
        ),
        isAppTitle: true,
        title: "Admin Panel",
        isLeading: true,
        leading: IconButton(
          onPressed: () {
            drawerKey.currentState.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
      drawer: myDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 28,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                "Welcome Admin",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Total Cars Approved",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Text(
              carsApproved.toString(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green[600],
              ),
            ),
            SizedBox(
              height: 33,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AllUsers()),
                  ),
                  child: AdminCard(
                    titleIcon:
                        Icon(Icons.supervised_user_circle, color: Colors.white),
                    backgroundColor: Colors.amber,
                    title: "Users",
                    content: countUsers.toString(),
                    titleColor: Colors.indigo,
                    contentColor: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllCars())),
                  child: AdminCard(
                    titleIcon: Icon(
                      Icons.drive_eta,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.indigo,
                    title: "Cars",
                    content: countCar.toString(),
                    titleColor: Colors.amber,
                    contentColor: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: AdminCard(
                      titleIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.pink,
                      title: "Agencies",
                      content: countAgency.toString(),
                      titleColor: Colors.white,
                      contentColor: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget),
          );
        },
      ),
    );
  }
}
