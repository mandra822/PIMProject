import 'package:expences_spliter/pages/expences.dart';
import 'package:expences_spliter/pages/groups.dart';
import 'package:expences_spliter/pages/home.dart';
import 'package:expences_spliter/pages/singleGroup.dart';
import 'package:expences_spliter/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const SingleGroup(),
    );
  }
}
