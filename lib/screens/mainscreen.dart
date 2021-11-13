import 'package:flutter/material.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({Key? key}) : super(key: key);

  
  static const routename = '/mainscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mainscreen'),
      ),
      body: const Center(
        child: Text('Welcome to mainscreen!'),
      ),
    );
  }
}