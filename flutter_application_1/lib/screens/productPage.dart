import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/services/firebaseServices.dart';
import 'package:flutter_application_1/widgets/customActionBar.dart';
import 'package:flutter_application_1/widgets/swipeImage.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserid())
        .collection("cart")
        .doc(widget.productId)
        .set({"Book": 1});
  }

  //Scack bar will show the user that the book is been added to the cart
  final SnackBar _snackBar = SnackBar(content: Text("Product Added to cart"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pPage.jpg'), fit: BoxFit.cover)),
      child: Stack(
        children: [
          //to get all the details of the product and show in the product page
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                //It is Firebase doucment data map
                Map<String, dynamic> documentData = snapshot.data.data();

                //List of the images
                List imageList = documentData['image'];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    //For Name of Book and Heading
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 24,
                      ),
                      child: Text(
                        "${documentData['name']}" ?? "Product Name",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    //For price of the book
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 24,
                      ),
                      child: Text(
                        "₹ ${documentData['price']}" ?? "Price",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigoAccent),
                      ),
                    ),
                    //For description
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      child: Text(
                        "${documentData['description']}" ?? "Description",
                        style: Constants.description,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 200, left: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(12.0)),
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage("assets/images/cart.png"),
                              width: 35,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await _addToCart();
                                //This is will call Snack Bar
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                height: 65,
                                margin: EdgeInsets.only(left: 16, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.brown[900],
                                    borderRadius: BorderRadius.circular(12.0)),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
              //Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionbar(
            hasBackArrow: true,
            hasTitle: false,
            hasBackground: false,
          )
        ],
      ),
    ));
  }
}
