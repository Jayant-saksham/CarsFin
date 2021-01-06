import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Cars/UI/Widgets/AppBar.dart';
import 'package:Cars/UI/Widgets/circularProgress.dart';

var userReference = FirebaseFirestore.instance.collection("Users");

class AllUsers extends StatefulWidget {
  @override
  AllUsersState createState() => AllUsersState();
}

class AllUsersState extends State<AllUsers> {
  List users = [];
  getAllUser() async {
    userReference.get().then(
      (snapshot) {
        snapshot.docs.forEach(
          (element) {
            setState(() {
              users.add(element.data());
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Users",
        isLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: userReference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: users.map((user) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user["Image"]),
                    ),
                    subtitle: Text(user["Phone Number"]),
                    title: Text(user["userName"]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Container(
                                height: 300,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          NetworkImage(user["Image"]),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Text(
                                        "Confirm to delete ${user["userName"]} ? ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MaterialButton(
                                          color: Colors.red,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Icon(Icons.delete,
                                                    color: Colors.white),
                                              ],
                                            ),
                                          ),
                                          onPressed: () async {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return Container(
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              },
                                            );
                                            await deleteUser(
                                                user["Phone Number"]);
                                            Navigator.pop(context);
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        super.widget,
                                              ),
                                            );
                                          },
                                        ),
                                        MaterialButton(
                                          color: Colors.green,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                Icon(Icons.cancel,
                                                    color: Colors.white),
                                              ],
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
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

  Future<void> deleteUser(String phoneNumber) async {
    var response = FirebaseFirestore.instance;
    await response.collection("Users").doc(phoneNumber).delete();
  }
}
