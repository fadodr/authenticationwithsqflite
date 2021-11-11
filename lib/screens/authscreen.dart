import 'package:flutter/material.dart';
import 'package:hoblist/screens/loginscreen.dart';

class Authscreen extends StatelessWidget{
  const Authscreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('hoblist', style: TextStyle(
          color: Colors.white,
          fontSize: 14
        ),),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.blue
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('HobList', style: TextStyle(
              color: Colors.white,
              fontSize: 24
            ),),
            const SizedBox(height: 8,),
            const Text('we are only interested in getting to know your preffered movie list', style: TextStyle(
              color: Colors.white,
              fontSize: 14
            ),),
            const SizedBox(height: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                primary: Colors.white,
                minimumSize: const Size(double.infinity, 50)
              ),
              onPressed: (){
                Navigator.of(context).pushNamed(Loginscreen.routename, arguments: Auth.login);
              }, 
              child: const Text('Log in', style: TextStyle(
                color: Colors.black
              ),)), 
            const SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(
                  color: Colors.white,
                  width: 2
                ),
                primary: Colors.blue,
                minimumSize: const Size(double.infinity, 50)
              ),
              onPressed: (){
                Navigator.of(context).pushNamed(Loginscreen.routename, arguments: Auth.signup);
              }, 
              child: const Text('Sign up', style: TextStyle(
                color: Colors.white
              ),))
          ],
        ),
      ),
    );
  }
}