import 'package:flutter/material.dart';
import 'package:hoblist/provider/authprovider.dart';
import 'package:hoblist/screens/authscreen.dart';
import 'package:hoblist/screens/loginscreen.dart';
import 'package:hoblist/screens/mainscreen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Authprovider())
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white
        ),
        home: const Authscreen(),
        routes: {
          Loginscreen.routename : (ctx) => const Loginscreen(),
          Mainscreen.routename : (ctx) => const Mainscreen()
        },
      ),
    );
  }
}