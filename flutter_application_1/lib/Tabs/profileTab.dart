import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/screens/profilePage.dart';
import 'package:flutter_application_1/widgets/customActionBar.dart';
import 'package:flutter_application_1/widgets/customBtn.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 300),
              child: Column(
                children: [
                  Text(
                    "Tell us about yourself...",
                    style: Constants.boldonBoardHeading,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: CustomBtn(
                      text: "Add Your Profile",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 700),
              child: CustomBtn(
                text: "Signout",
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                outlineBtn: false,
              )),
          CustomActionbar(
            hasBackArrow: false,
            title: "Your Profile...",
          )
        ],
      ),
    );
  }
}
