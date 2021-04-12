import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/getStarted.dart';
import 'package:flutter_application_1/screens/homePage.dart';
import 'package:flutter_application_1/screens/loginPage.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        //HERE CONNECTION IS MADE THROUGH FIREBASE
        if (snapshot.connectionState == ConnectionState.done) {
          //HERE STREAM BUILDER CHECKS AUTHENTICATION LIVE
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Error: ${streamSnapshot.error}'),
                    ),
                  );
                }
                //CONNECTION STATE ACTIVE IT DOES THE USER LOGIN CHECK
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  //GET USER
                  User _user = streamSnapshot.data;
                  //USER CHECKING IF NOT LOGGED IN THEN LOGINPAGE ELSE GOES TO HOME PAGE
                  if (_user == null) {
                    //return GetStartedPage();
                    return LoginPage();
                  } else {
                    return HomePage();
                  }
                }
                return Scaffold(
                  body: Center(
                    child: Text("Checking Authentication..."),
                  ),
                );
              });
        }
        return Scaffold(
          body: Center(
            child: Text("Initializing app"),
          ),
        );
      },
    );
  }
}
