import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/screens/cartPage.dart';
import 'package:flutter_application_1/services/firebaseServices.dart';

class CustomActionbar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;
  CustomActionbar(
      {this.hasBackArrow, this.title, this.hasTitle, this.hasBackground});

  FirebaseServices _firebaseServices = FirebaseServices();
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    bool _backArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(colors: [
                  Colors.brown[800],
                  Colors.brown[400].withOpacity(0.2)
                ], begin: Alignment(0, 0), end: Alignment(0, 1))
              : null),
      padding:
          EdgeInsets.only(top: 56.0, left: 24.0, right: 24.0, bottom: 42.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_backArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("assets/images/backArrow.png"),
                  width: 25.0,
                  height: 25.0,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? "ACTION BAR",
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                child: StreamBuilder(
                  //This will get data realtime so we dont need to do it agian and again
                  stream: _usersRef
                      .doc(_firebaseServices.getUserid())
                      .collection("cart")
                      .snapshots(),
                  builder: (context, snapshot) {
                    int _totalItems = 0;
                    if (snapshot.connectionState == ConnectionState.active) {
                      List _docu = snapshot.data.docs;
                      _totalItems = _docu.length;
                    }
                    return Text(
                      "$_totalItems" ?? "0",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
