import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/screens/loginPage.dart';
import 'package:flutter_application_1/widgets/customBtn.dart';

class GetStartedPage extends StatefulWidget {
  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 100),
                child: Text(
                  'Collaborative',
                  style: TextStyle(color: Colors.blue[900], fontSize: 28),
                )),
            Container(
              margin: EdgeInsets.all(32),
              child: Text(
                'New platform for students to sell books and help gain knowledge to other students...',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.indigo[900],
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
            )
          ],
        )),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Center(
            child: Image.asset("assets/images/splash_bg.png"),
          ),
        ),
        Container(
          child: Center(
            child: CustomBtn(
              text: "Let\'s Get Started...",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              outlineBtn: false,
            ),
          ),
        )
      ],
    )));
  }
}
