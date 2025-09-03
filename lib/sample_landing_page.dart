 import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:test_project/pages/home_page.dart';
import 'package:test_project/pages/login_page.dart';
import 'package:test_project/pages/profile_page.dart';
import 'package:test_project/pages/settings.dart';

 class SampleLanding extends StatefulWidget {
   const SampleLanding({super.key});

   @override
   State<SampleLanding> createState() => _SampleLandingState();
 }

 class _SampleLandingState extends State<SampleLanding> {
   int selectedPos = 0;
   double bottomNavBarHeight = 60;

   List<TabItem> tabItems = [
     TabItem(Icons.home, "Home", Colors.purple),
     TabItem(Icons.person, "Profile", Colors.purple),
     TabItem(Icons.settings, "Settings", Colors.purple),

   ];

   late CircularBottomNavigationController _navigationController;

   final List<Widget> pages = [

     HomePage(),
     ProfilePage(),
     Settings(),
   ];

   @override
   void initState() {
     print("ffffffffffffffffffffffff");
     super.initState();
     _navigationController = CircularBottomNavigationController(selectedPos);
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Stack(
         children: <Widget>[
           Padding(
             padding: EdgeInsets.only(bottom: bottomNavBarHeight),
             child: pages[selectedPos], // Use selected page
           ),
           Align(alignment: Alignment.bottomCenter, child: bottomNav())
         ],
       ),
     );
   }

   Widget bottomNav() {
     return CircularBottomNavigation(
       tabItems,
       controller: _navigationController,
       selectedPos: selectedPos,
       barHeight: bottomNavBarHeight,
       barBackgroundColor: Colors.white,
       backgroundBoxShadow: <BoxShadow>[
         BoxShadow(color: Colors.black45, blurRadius: 10.0),
       ],
       animationDuration: Duration(milliseconds: 300),
       selectedCallback: (int? selectedPos) {
         setState(() {
           this.selectedPos = selectedPos ?? 0;
         });
       },
     );
   }

   @override
   void dispose() {
     _navigationController.dispose();
     super.dispose();
   }
 }
