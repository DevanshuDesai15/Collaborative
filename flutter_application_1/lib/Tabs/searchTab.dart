import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/services/firebaseServices.dart';
import 'package:flutter_application_1/widgets/customInput.dart';
import 'package:flutter_application_1/widgets/productCart.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchStr = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        if (_searchStr.isEmpty)
          Center(
            child: Container(
              child: Text(
                'Finding Books?? Then Search Here!!!',
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          )
        else
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef
                .orderBy("name")
                .startAt([_searchStr]).endAt(["$_searchStr\uf8ff"]).get(),
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
        Padding(
          padding: const EdgeInsets.only(top: 45),
          child: CustomInput(
            hintText: "Find Book...",
            onSubmitted: (value) {
              setState(() {
                _searchStr = value;
              });
            },
          ),
        ),
        // Text(
        //   'Finding some books ?? Search here!!!',
        //   style: Constants.onBoardingNormalText,
        // ),
      ],
    ));
  }
}
