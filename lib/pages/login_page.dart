import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_project/pages/signup_page.dart';

import '../formvalidators.dart';

import '../progress_bar.dart';
import '../sample_landing_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with FormValidators {

  TextEditingController userLoginEmailController = TextEditingController();
  TextEditingController userLoginPasswordController = TextEditingController();
  final GlobalKey<FormState> userLoginFormKey = GlobalKey<FormState>();
  CollectionReference usersRef = FirebaseFirestore.instance.collection("users");
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool _passwordVisible = false;


  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: willPopControll,
        child: Scaffold(
          body:
          SingleChildScrollView(
              child: Form(
                key: userLoginFormKey,
                child: Column(
                  children: [

                Image.asset('assets/images/shopv.png',height: 250,),

                Text(
              "login",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),

                SizedBox(
                  height: 20,
                ),


                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Colors.purple,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        controller: userLoginEmailController,
                        validator: validateEmail,
                        decoration: InputDecoration(labelText: 'Email',



                            contentPadding: EdgeInsets.symmetric(vertical: 9.0),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(15)),


                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.black,
                              size: 20,
                            ),
                            // fillColor: AppColors.textFieldColor,
                            filled: false,
                            hintText: "email",
                            hintStyle: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.purple,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    controller: userLoginPasswordController,
                    validator: validatePassword,

                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black,
                          size: 20,
                        ),
                        //   fillColor: AppColors.textFieldColor,
                        filled: false,
                        hintText: "password",
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ), SizedBox(
                      height: 5,
                    ),

                SizedBox(
                  height: 30,
                ),
                TextButton(onPressed: () {

                },
                    child: Text("forgot password",
                      style: TextStyle(color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),)),
                SizedBox(
                  height: 7,
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide.none)
                    ),
                    onPressed: () {
                     if (userLoginFormKey.currentState!.validate())
                    loginToFirebase(
                        userLoginEmailController.text.trim(),
                        userLoginPasswordController.text.trim(),
                    );

                    },
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                      child: Text(
                          "login",style: TextStyle(color: Colors.white),
                      ),
                    )),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(
                "don't have an accout yet?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),

              ),
              SizedBox(
                width: 2,
              ),
              TextButton(
                onPressed: () {
                Navigator.push
                  (context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
                },
                child: Text(
                  ("signup"),
                       style: TextStyle(color: Colors.purple, fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              ),
          //   Text("SIGN UP", style: TextStyle(color: Colors.blue, fontSize: 15.sp),)
          ],
        ), Text("OR", style: TextStyle(color: Colors.black,
        fontWeight: FontWeight.bold, fontSize: 18),),
        SizedBox(
          width: 2,
        ),
        if(Platform.isAndroid)
    Row(mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(height: 7, width: 10,
          decoration: const BoxDecoration(image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/goggleimage.jpeg'),
          ), shape: BoxShape.circle),),
        TextButton(onPressed: () {
          signInWithGoogle(context);
        }, child: Text("google signup",
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),)

        )
      ],)
    ,

    ],
    ),
    ),
    ),
    ),
    );
  }




  Future<bool> willPopControll() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            //  title: new Text('Are you sure?'),
            content: const Text('Do you want to exit the App'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => exitApp(),
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ],
          ),
    )) ??
        false;
  }

  exitApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  void signInWithGoogle(BuildContext context) {}


  Future<void> startLoader() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: const Center(child: ProgressBar(),),
        );
      },
    );

  }




  Future<void> stopLoading() async {
    Navigator.of(context).pop();
  }

  Future loginToFirebase(String email, String password) async {
    print("print first line on loginToFirebase");
    try {
      await startLoader(); // Show loading spinner
      print("print second line on loginToFirebase");
      User? firebaseUser = (await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      await stopLoading(); // Hide loader

      if (firebaseUser != null) {
        print("print user name asssssssssssss${firebaseUser.displayName}");
        print("print user email asssssssssssss${firebaseUser.email}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SampleLanding(),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.purple,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            content: const Text("Signup successfully",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        );

        return firebaseUser.uid;
      } else {
        print("the user is nulllllllllllllllllllllllllll");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login failed. Please try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      await stopLoading(); // Hide loader even if error occurs

      String errMssg = "An error occurred. Please try again.";

      switch (e.code) {
        case "invalid-email":
          errMssg = "The email address is invalid.";
          break;

        case "user-disabled":
          errMssg = "This user account has been disabled.";
          break;

        case "wrong-password":
          errMssg = "The password is incorrect for this email.";
          break;

        case "user-not-found":
          errMssg = "No account found with this email.";
          break;
      }


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errMssg),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      await stopLoading();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }






}
 