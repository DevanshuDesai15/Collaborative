import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/customActionBar.dart';

class SellTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Sell Tab"),
          ),
          CustomActionbar(
            hasBackArrow: false,
            title: "Sell",
          )
        ],
      ),
    );
  }
}
