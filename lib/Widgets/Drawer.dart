import 'package:Cars/Themes/constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:io';

Widget myDrawer(String userName, String userEmail, File userImage) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
          accountEmail: userEmail==null? Text(""): Text(
            "${userEmail}",
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
              image: userImage == null ? NetworkImage('') : FileImage(userImage),
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
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text("Account"),
          leading: Icon(EvaIcons.personOutline),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text("Cars"),
          leading: Icon(EvaIcons.hardDrive),
        ),
        SizedBox(height: 20),
        Divider(),
        ListTile(
          title: Text("Help"),
          leading: Icon(EvaIcons.questionMarkCircleOutline),
        ),
        ListTile(
          title: Text("Share"),
          leading: Icon(EvaIcons.share),
        ),
        ListTile(
          title: Text("Rate us"),
          leading: Icon(EvaIcons.edit2),
        ),
        SizedBox(
          height: 80,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  child: IconButton(
                    iconSize: 15,
                    icon: Icon(Icons.share),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text("Share"),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  child: IconButton(
                    iconSize: 15,
                    icon: Icon(Icons.message),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text("Feedback"),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  child: IconButton(
                    iconSize: 15,
                    icon: Icon(Icons.star),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text("Rate Us"),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
