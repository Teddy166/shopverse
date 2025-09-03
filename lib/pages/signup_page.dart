

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/formvalidators.dart';

import 'package:test_project/pages/home_page.dart';
import 'package:test_project/pages/login_page.dart';

import '../global_varaibles.dart';
import '../progress_bar.dart';
import '../sample_landing_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

@override
_SignupPageState createState() => _SignupPageState();
  }

class _SignupPageState extends State<SignupPage> with FormValidators{

  TextEditingController userSignupConfirmPassword = TextEditingController();
  TextEditingController userSignupPhoneController = TextEditingController();
  TextEditingController userSignupAddressController = TextEditingController();
  TextEditingController userSignupNameController = TextEditingController();
  TextEditingController userSignupEmailController = TextEditingController();
  TextEditingController userSignupPasswordController = TextEditingController();
  TextEditingController userSignupAboutController = TextEditingController();
  final GlobalKey<FormState> userSignupFormKey = GlobalKey<FormState>();


  CollectionReference usercollection =FirebaseFirestore.instance.collection("users");

  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false ;
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
            key: userSignupFormKey,
            child: Column(
              children: [

                Image.asset('assets/images/shopv.png',height: 250,),

                Text(
                  "signup",
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
                    controller: userSignupEmailController,
                       //validator: (value) => validateEmail(value),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
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
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.purple,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    controller: userSignupPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value != userSignupPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },

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
                  height: 15,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.purple,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    controller: userSignupConfirmPassword,
                    // validator: validatePassword,

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
                        hintText: "confirmpassword",
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ), SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.purple,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    controller: userSignupNameController,
                    //validator: validateEmail,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 20,
                        ),
                        // fillColor: AppColors.textFieldColor,
                        filled: false,
                        hintText: "name",
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.purple,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    controller: userSignupAddressController,
                    //validator: validateEmail,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: const Icon(
                          Icons.home,
                          color: Colors.black,
                          size: 20,
                        ),
                        // fillColor: AppColors.textFieldColor,
                        filled: false,
                        hintText: "address",
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.purple,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    controller: userSignupPhoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Phone number must be digits only';
                      } else if (value.length != 11) {
                        return 'Phone number must be 11 digits';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.black,
                          size: 20,
                        ),
                        // fillColor: AppColors.textFieldColor,
                        filled: false,
                        hintText: "phone number",
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),


                TextButton(onPressed: () {

                },
                    child: Text("forgot password",
                      style: TextStyle(color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),)),
                SizedBox(
                  height: 17,
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide.none)),
                    onPressed: () {

                      submit();

                    },
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                      child: Text(
                          "signup",style: TextStyle(color: Colors.white),),
                    )),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "have an accout?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()),
                          );
                        },
                        child: Text(
                          "login",
                          style: TextStyle(color: Colors.purple, fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ))
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
    throw UnimplementedError();
  }
  void login() async {

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

  void submit() {
    if (userSignupFormKey.currentState!.validate()) {
      if (userSignupPasswordController.text != userSignupConfirmPassword.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            content: const Text(
              "Password and Confirm Password do not match",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        return; // stop the signup process
      }

      startLoader();
      regWithEmailAndPassword(
        userSignupEmailController.text.trim(),
        userSignupPasswordController.text.trim(),
      );
      print("--- SIGNUP PROCESS STARTED ---");
    }
  }


  Future regWithEmailAndPassword(String email, String password) async {
    //startLoader();
    try {
      print("Attempting to create user with email: $email");
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password,
      );

      print("Checking if userCredential.user is null: ${userCredential.user == null}");
      if(userCredential.user != null ){

        print("User is not null. Preparing Firestore data.");
        String fullName = userSignupNameController.text.trim();
        String avatarUrl = "https://ui-avatars.com/api/?name=${Uri.encodeComponent(fullName)}";

        CustomUser customUser = CustomUser(
          firebaseuser: userCredential.user,
        );

        try {
          print("Attempting to save user data to Firestore for UID: ${customUser.firebaseuser!.uid}");
          await usercollection.doc(customUser.firebaseuser!.uid).set({
            'name': userSignupNameController.text,
            'address':userSignupAddressController.text,
             'phoneNumber':userSignupPhoneController.text,
               'email':userSignupEmailController.text,
            'photoUrl': avatarUrl,
            'about' : '',
            'id': customUser.firebaseuser!.uid,
            'createdAt': DateTime
                .now()
                .millisecondsSinceEpoch
                .toString(),

          });
          print("User data saved to Firestore successfully.");

          //stopLoading();
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


          print("Navigating to SampleLanding...");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SampleLanding()),
                (Route<dynamic> route) => false,
          );

          //   stopLoading();

        }catch(e){

          //stopLoading();
          print("Error saving user to Firestore: $e");
        }
      }
    //stopLoading();

    } on FirebaseAuthException catch(e){
      var errorMsg = "An error has occurred";
      switch(e.code){
        case "email-already-in-use":
          errorMsg = "The Email Address already exist pls";
          break;

        case "operation-not-allowed":
          errorMsg = "The User Account is not enabled";
          break;

        case "invalid-email":
          errorMsg = "The Email Address is not valid";
          break;

        case "weak-password":
          errorMsg = "The password provided is too weak.";
          break;
          print("checking for weak password");
      }
      print("--- SIGNUP PROCESS ENDED ---");
      stopLoading();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          content: Text(errorMsg, style: const TextStyle(color: Colors.white,fontSize: 16),)));
      rethrow;
    }


  }

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

}


class CustomUser {
  User? firebaseuser;

  CustomUser({this.firebaseuser});
}