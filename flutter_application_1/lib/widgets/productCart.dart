import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/screens/productPage.dart';

class ProductCart extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;

  ProductCart(
      {this.imageUrl, this.productId, this.onPressed, this.price, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(
                      productId: productId,
                    )));
      },
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
          height: 300.0,
          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    "$imageUrl",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: Constants.productHeading,
                      ),
                      Text(
                        price,
                        style: Constants.productHeading,
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
