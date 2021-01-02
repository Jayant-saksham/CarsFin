import 'package:Cars/Themes/constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:Cars/backend/FirebaseAuth.dart';
import 'package:Cars/UI/Pages/Login/Login.dart';
import 'package:Cars/UI/AdminPanel/AdminPanel.dart';
import 'package:Cars/UI/Pages/SellCar/SellCar.dart';
import 'package:Cars/UI/Pages/ContactUs/ContactUs.dart';
import 'package:Cars/UI/Pages/HomePage/AvailableCars.dart';
import 'package:Cars/UI/Pages/UserProfile/UserProfile.dart';

Widget myDrawer(
    String userName, String phoneNumber, String userImage, context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
          accountEmail: Text(
            "${phoneNumber}",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          accountName: Text(
            "${userName}",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          currentAccountPicture: ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Image(
              image: userImage == null
                  ? NetworkImage('')
                  : NetworkImage(userImage),
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        ListTile(
            title: Text("Home"),
            leading: Icon(EvaIcons.homeOutline),
            onTap: () {
              Navigator.pop(context);
            }),
        SizedBox(height: 10),
        ListTile(
            title: Text("Account"),
            leading: Icon(EvaIcons.personOutline),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            }),
        SizedBox(height: 10),
        ListTile(
            title: Text("Cars"),
            leading: Icon(EvaIcons.hardDrive),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AvailableCars(),
                ),
              );
            }),
        SizedBox(height: 10),
        SizedBox(height: 20),
        Divider(),
        ListTile(
            title: Text("Help"),
            leading: Icon(EvaIcons.questionMarkCircleOutline),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs(),));
            }),
        SizedBox(height: 10),
        ListTile(
            title: Text("Share"),
            leading: Icon(EvaIcons.share),
            onTap: () {
              Navigator.pop(context);
            }),
        SizedBox(height: 10),
        ListTile(
            title: Text("Rate us"),
            leading: Icon(EvaIcons.edit2),
            onTap: () {
              Navigator.pop(context);
            }),
        SizedBox(height: 10),
        ListTile(
          title: Text("Logout"),
          leading: Icon(EvaIcons.logOut),
          onTap: () => AuthService().signOut(),
        ),
        SizedBox(
          height: 100,
        ),
      ],
    ),
  );
}
