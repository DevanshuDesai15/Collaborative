import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebaseServices.dart';
import 'package:flutter_application_1/widgets/customActionBar.dart';
import 'package:flutter_application_1/widgets/customBtn.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CustomActionbar(
            hasBackArrow: true,
            title: "Add Profile",
            hasBackground: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: name(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: email(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: dob(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: about(),
          ),
          CustomBtn(
            text: "Submit",
          )
        ],
      ),
    );
  }

  Widget name() {
    return TextFormField(
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            prefixIcon: Icon(Icons.person),
            labelText: "Name",
            helperText: "It can't be empty",
            hintText: "Your Name"));
  }

  Widget email() {
    return TextFormField(
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            prefixIcon: Icon(Icons.mail),
            labelText: "E-mail",
            helperText: "It can't be empty",
            hintText: "Your email"));
  }

  Widget dob() {
    return TextFormField(
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            prefixIcon: Icon(Icons.cake),
            labelText: "Date of Birth",
            helperText: "In dd/mm/yyyy",
            hintText: "Your Birth Date!!!"));
  }

  Widget about() {
    return TextFormField(
        maxLines: 4,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            prefixIcon: Icon(Icons.info),
            labelText: "About",
            helperText: "It can't be empty",
            hintText: "Tell us about yourself..."));
  }
}
