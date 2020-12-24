import 'package:Cars/Models/Cars.dart';
import 'package:Cars/Models/Agency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:Cars/Models/Users.dart';

var userReference = FirebaseFirestore.instance.collection("Users");
var agencyReference = FirebaseFirestore.instance.collection("Agency");

class FirebaseFunctions {
  Future<void> createUserRecord(Users users) async {
    if (users.image != null) {
      final FirebaseStorage storage =
          FirebaseStorage(storageBucket: 'gs://carsfin-5a805.appspot.com');
      String imagePath = "Users/Images/${users.phoneNumber}.png";
      String userImageUrl;
      UploadTask uploadTask;
      uploadTask = storage.ref().child(imagePath).putFile(users.image);
      var url = (await uploadTask).ref.getDownloadURL().then(
            (value) => userImageUrl = value.toString(),
          );

      var response = await FirebaseFirestore.instance
          .collection("Users")
          .doc(users.phoneNumber)
          .set(
        {
          "userName": users.name,
          "Phone Number": users.phoneNumber,
          "Location": "",
          "Cars Sold": 0,
          "Cars bought": 0,
          "TimeStamp": DateTime.now(),
          "Image": userImageUrl,
        },
      );
    } else {
      var response = await FirebaseFirestore.instance
          .collection("Users")
          .doc(users.phoneNumber)
          .set(
        {
          "userName": users.name,
          "Phone Number": users.phoneNumber,
          "Location": "",
          "Cars Sold": 0,
          "Cars bought": 0,
          "TimeStamp": DateTime.now(),
          "Image": "",
        },
      );
    }
  }

  Future<void> createCarRecord(Car car) async {
    final FirebaseStorage storage =
        FirebaseStorage(storageBucket: 'gs://carsfin-5a805.appspot.com');
    List<String> imageUrl = [];

    UploadTask uploadTask;
    for (int i = 0; i < car.images.length; i++) {
      String imagePath = "Cars/Images/${car.carNumber}/${car.carNumber}.png";
      uploadTask = storage.ref().child(imagePath).putFile(car.images[i]);

      var url = (await uploadTask)
          .ref
          .getDownloadURL()
          .then((value) => imageUrl.add(value.toString()));
    }

    var response = FirebaseFirestore.instance;
    await response.collection("Cars").doc(car.carNumber).set(
      {
        "TimeStamp": DateTime.now().toString(),
        "Price": car.price,
        "Car Number": car.carNumber,
        "Car brand": car.brand,
        "Car Model": car.model,
        "Has Pollution": car.hasPollution,
        "Has RC": car.hasRC,
        "Has Insurance": car.hasInsurance,
        "Dealer Name": car.dealerName,
        "Dealer PhoneNumber": car.dealerPhoneNumber,
        "Dealer Email": car.sellerEmail,
        "Is Approved": false,
        "Date of Purchased": car.dateofPurchased,
        "Milage": car.milage,
        "Car Location": car.location,
        "Seats": 4,
        "Other Features": car.otherFeatures,
        "KM Driven": car.kmDriven,
        "Images": imageUrl,
      },
    );
  }

  Future<void> createAgency(Agency agency) async {
    if (agency.images != null) {
      final FirebaseStorage storage =
          FirebaseStorage(storageBucket: 'gs://carsfin-5a805.appspot.com');
      String imagePath = "Agency/Images/${agency.agencyPhoneNumber}.png";

      UploadTask uploadTask;
      uploadTask = storage.ref().child(imagePath).putFile(agency.images);
      String agencyurl =
          await (await uploadTask).ref.getDownloadURL().toString();
      var response = await FirebaseFirestore.instance
          .collection("Agency")
          .doc(agency.agencyPhoneNumber)
          .set(
        {
          "Phone Number": agency.agencyPhoneNumber,
          "Name": agency.agencyName,
          "Location": agency.agencyLocation,
          "Cars Sold": agency.carsSold,
          "Car Uploaded": agency.carsUploaded,
          "Email": agency.agencyEmail,
          "Image": agencyurl,
          "TimeStamp": DateTime.now(),
        },
      );
    } else {
      var response = await FirebaseFirestore.instance
          .collection("Agency")
          .doc(agency.agencyPhoneNumber)
          .set(
        {
          "Timestamp": DateTime.now().toString(),
          "Phone Number": agency.agencyPhoneNumber,
          "Name": agency.agencyName,
          "Location": agency.agencyLocation,
          "Cars Sold": agency.carsSold,
          "Car Uploaded": agency.carsUploaded,
          "Email": agency.agencyEmail,
          "Image": "",
        },
      );
    }
  }

  Future getUser(String phoneNumber) async {
    String phoneNumbe =
        phoneNumber.substring(0, 3) + " " + phoneNumber.substring(3, 13);
    print(phoneNumbe);
    final DocumentSnapshot documentSnapshot =
        await userReference.doc(phoneNumbe).get();
    print(documentSnapshot.data());
  }

  Future getAgency(String phoneNumber) async {
    final DocumentSnapshot documentSnapshot =
        await agencyReference.doc(phoneNumber).get();
    return documentSnapshot.data();
  }

  Future<bool> checkIfUserExist(String phoneNumber) async {
    String phoneNumbe =
        phoneNumber.substring(0, 3) + " " + phoneNumber.substring(3, 13);
    final DocumentSnapshot documentSnapshot =
        await userReference.doc(phoneNumbe).get();
    print(documentSnapshot.data());
    if (documentSnapshot.exists) {
      return true;
    } else {
      return false;
    }
  }
}
