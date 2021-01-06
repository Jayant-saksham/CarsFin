import 'package:flutter/material.dart';
import 'package:Cars/UI/Widgets/AppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Cars/UI/Widgets/circularProgress.dart';
import 'package:hexcolor/hexcolor.dart';

var brandReference = FirebaseFirestore.instance.collection("Brands");

class AllBrands extends StatefulWidget {
  @override
  _AllBrandsState createState() => _AllBrandsState();
}

class _AllBrandsState extends State<AllBrands> {
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
      backgroundColor: HexColor('#F8FAFB'),
      appBar: appBar(
        title: "All Brands",
        isLeading: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: StreamBuilder(
        stream: brandReference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: brands.map(
                  (brand) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(brand["Image"]),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                height: 70,
                                width: 70,
                              ),
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  brand["Brand"],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  brand["Deals"].toString() + " deals",
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return circularProgress();
          } else {
            return circularProgress();
          }
        },
      ),
    );
  }
}
