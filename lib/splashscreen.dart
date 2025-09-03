import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_project/sample_landing_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    delayAndNavigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.purple,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30,),
               Center(child: Image.asset('assets/images/shopv.png')),
                /* Lottie.asset(
                    'assets/animation/moving-truck.json',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),*/
                // Text("Logistics & Dispatch Inventory Management",
                //   style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic,
                //       fontWeight: FontWeight.normal, fontSize: 14, decoration: TextDecoration.none),),
              ],
            ),
          ),
        )
    );

  }

  void delayAndNavigate() {

    Timer(const Duration(seconds: 8), ()=> Navigator
        .pushReplacement(context, MaterialPageRoute(builder: (context){

      return SampleLanding();



    })));
  }

}