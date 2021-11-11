import 'package:flutter/material.dart';
import 'package:hoblist/screens/authscreen.dart';
import 'package:hoblist/screens/loginscreen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      home: const Authscreen(),
      routes: {
        Loginscreen.routename : (ctx) => const Loginscreen(),
      },
    );
  }
}