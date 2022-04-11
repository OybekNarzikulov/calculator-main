import 'package:flutter/material.dart';
import 'my_calculator.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      // theme: ThemeData(primaryColor: Colors.blue),
      home: MyCalculator(),
    );
  }
}


