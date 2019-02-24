import 'package:flutter/material.dart';
import 'screens/loginscreen3.dart';
import 'screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

 final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async {
  bool isLoggedIn; 

  if (await _auth.currentUser() != null) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
  runApp(new MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp( {@required this.isLoggedIn });

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Travel Now',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? StartTravel() : LoginScreen3(),
      debugShowCheckedModeBanner: false,
    );
  }
}