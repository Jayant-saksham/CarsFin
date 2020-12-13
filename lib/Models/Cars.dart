import 'package:flutter/material.dart';

class Car {
  String brand;
  String model;
  double price;
  String condition;
  List<String> images;

  Car({this.brand, this.model, this.price, this.condition, this.images});
}

List<Car> getCarList() {
  return <Car>[
    Car(
      brand: "Land Rover",
      model: "Discovery",
      price: 2580,
      condition: "Weekly",
      images: [
        "assets/images/land_rover_0.png",
        "assets/images/land_rover_1.png",
        "assets/images/land_rover_2.png",
      ],
    ),
    Car(
      brand: "Alfa Romeo",
      model: "C4",
      price: 3580,
      condition: "Monthly",
      images: [
        "assets/images/alfa_romeo_c4_0.png",
      ],
    ),
    Car(
      brand: "Nissan",
      model: "GTR",
      price: 1100,
      condition: "Daily",
      images: [
        "assets/images/nissan_gtr_0.png",
        "assets/images/nissan_gtr_1.png",
        "assets/images/nissan_gtr_2.png",
        "assets/images/nissan_gtr_3.png",
      ],
    ),
    Car(
      brand: "Acura",
      model: "MDX 2020",
      price: 2200,
      condition: "Monthly",
      images: [
        "assets/images/acura_0.png",
        "assets/images/acura_1.png",
        "assets/images/acura_2.png",
      ],
    ),
    Car(
      brand: "Chevrolet",
      model: "Camaro",
      price: 3400,
      condition: "Weekly",
      images: [
        "assets/images/camaro_0.png",
        "assets/images/camaro_1.png",
        "assets/images/camaro_2.png",
      ],
    ),
    Car(
      brand: "Ferrari",
      model: "Spider 488",
      price: 4200,
      condition: "Weekly",
      images: [
        "assets/images/ferrari_spider_488_0.png",
        "assets/images/ferrari_spider_488_1.png",
        "assets/images/ferrari_spider_488_2.png",
        "assets/images/ferrari_spider_488_3.png",
        "assets/images/ferrari_spider_488_4.png",
      ],
    ),
    Car(
      brand: "Ford",
      model: "Focus",
      price: 2300,
      condition: "Weekly",
      images: [
        "assets/images/ford_0.png",
        "assets/images/ford_1.png",
      ],
    ),
    Car(
      brand: "Fiat",
      model: "500x",
      price: 1450,
      condition: "Weekly",
      images: [
        "assets/images/fiat_0.png",
        "assets/images/fiat_1.png",
      ],
    ),
    Car(
      brand: "Honda",
      model: "Civic",
      price: 900,
      condition: "Daily",
      images: [
        "assets/images/honda_0.png",
      ],
    ),
    Car(
      brand: "Citroen",
      model: "Picasso",
      price: 1200,
      condition: "Monthly",
      images: [
        "assets/images/citroen_0.png",
        "assets/images/citroen_1.png",
        "assets/images/citroen_2.png",
      ],
    ),
  ];
}

class Dealer {
  String name;
  int offers;
  String image;
  Dealer({this.name, this.offers, this.image});
}

List<Dealer> getDealerList() {
  return <Dealer>[
    Dealer(
      name: "Hertz",
      offers: 174,
      image: "assets/images/hertz.png",
    ),
    Dealer(
      name: "Avis",
      offers: 126,
      image: "assets/images/avis.png",
    ),
    Dealer(
      name: "Suzuki",
      offers: 89,
      image: "assets/images/suzuki.png",
    ),
    Dealer(
      name: "Toyota",
      offers: 89,
      image: "assets/images/toyota.png",
    ),
  ];
}

class Filter {
  String name;
  Filter(this.name);
}

List<Filter> getFilterList() {
  return <Filter>[
    Filter("Best Match"),
    Filter("Highest Price"),
    Filter("Lowest Price"),
  ];
}
