import 'package:flutter/material.dart';
import 'package:Cars/UI/Widgets/AppBar.dart';

class AllCars extends StatefulWidget {
  @override
  _AllCarsState createState() => _AllCarsState();
}

class _AllCarsState extends State<AllCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Car"
      ),
    );
  }
}
