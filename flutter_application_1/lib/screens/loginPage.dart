import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/onBoarding/onBoarding.dart';
import 'package:flutter_application_1/screens/registerPage.dart';
import 'package:flutter_application_1/widgets/customBtn.dart';
import 'package:flutter_application_1/widgets/customInput.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _alertDialogueBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Something Went Wrong!!!"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("close dialogue"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  //FOR CREATING A NEW USER
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e;
    }
  }

  //SUBMIT FORM
  void _submitForm() async {
    setState(() {
      _loginFormLoading = true;
    });

    String _signInFeedback = await _loginAccount();
    if (_signInFeedback != null) {
      _alertDialogueBuilder(_signInFeedback);
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  //DEFAULT FORM LOADIND STATE
  bool _loginFormLoading = false;

  //FORM INPUT FIELD VALUES
  String _loginEmail = "";
  String _loginPassword = "";

  //CRETAE A FOCUS NODE
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[600],
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/books.jpg'),
                  fit: BoxFit.cover)),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 24),
                child: Column(
                  children: [
                    Text(
                      'Collaborative',
                      textAlign: TextAlign.center,
                      style: Constants.largeHeading,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        'You can Login Here...',
                        textAlign: TextAlign.center,
                        style: Constants.boldHeading,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "New Email...",
                    onChnaged: (value) {
                      _loginEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: "New Password...",
                    onChnaged: (value) {
                      _loginPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPassword: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  CustomBtn(
                    text: "Login",
                    onPressed: () {
                      _submitForm();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnBoardingPage()));
                    },
                    isLoading: _loginFormLoading,
                    outlineBtn: false,
                  )
                ],
              ),
              CustomBtn(
                text: "Create An Account",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                outlineBtn: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
