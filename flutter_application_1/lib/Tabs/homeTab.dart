import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/screens/productPage.dart';
import 'package:flutter_application_1/services/firebaseServices.dart';
import 'package:flutter_application_1/widgets/customActionBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/widgets/productCart.dart';

class HomeTab extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }
              //Data to display
              if (snapshot.connectionState == ConnectionState.done) {
                //Display data inside list view
                return ListView(
                  padding: EdgeInsets.only(top: 150.0, bottom: 2.0),
                  children: snapshot.data.docs.map((document) {
                    return ProductCart(
                      title: document.data()['name'],
                      imageUrl: document.data()['image'][0],
                      price: "${document.data()['price']}",
                      productId: document.id,
                    );
                  }).toList(),
                );
              }
              //If in a Loading state
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionbar(
            hasBackArrow: false,
            title: "Home",
          )
        ],
      ),
    );
  }
}
