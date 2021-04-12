import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //Method for userid which is used in our app
  String getUserid() {
    return _firebaseAuth.currentUser.uid;
  }

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection("Books");

  //This is for users
  final CollectionReference usersRef = FirebaseFirestore.instance.collection(
      "Users"); //Here User->UserId(Document)->Cart->BookId(Document)
}
