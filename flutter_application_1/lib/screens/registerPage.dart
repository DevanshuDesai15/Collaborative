import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/onBoarding/onBoarding.dart';
import 'package:flutter_application_1/screens/loginPage.dart';
import 'package:flutter_application_1/widgets/customBtn.dart';
import 'package:flutter_application_1/widgets/customInput.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //ALERT DIALOGUE BOX TO SHOW THE ERRORS
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
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
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
      _registerFormLoading = true;
    });

    String _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      _alertDialogueBuilder(_createAccountFeedback);
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  //DEFAULT FORM LOADIND STATE
  bool _registerFormLoading = false;

  //FORM INPUT FIELD VALUES
  String _registerEmail = "";
  String _registerPassword = "";

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
                  image: AssetImage('assets/images/register.jpg'),
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
                        'Registration For New Account',
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
                      _registerEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: "New Password...",
                    onChnaged: (value) {
                      _registerPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPassword: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  CustomBtn(
                    text: "Create New Account",
                    onPressed: () {
                      _submitForm();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnBoardingPage()));
                    },
                    isLoading: _registerFormLoading,
                    outlineBtn: false,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomBtn(
                  text: "Already Have an Account ?",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  outlineBtn: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
