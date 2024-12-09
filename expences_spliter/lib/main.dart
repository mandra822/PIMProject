import 'package:expences_spliter/pages/balance.dart';
import 'package:expences_spliter/pages/home.dart';
import 'package:expences_spliter/pages/loginPage.dart';
import 'package:expences_spliter/pages/signUpPage.dart';
import 'package:expences_spliter/pages/singleGroup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Splitter',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/singleGroup': (context) => SingleGroup(groupId: '',), 
        '/balance': (context) => GroupExpensesPage(groupId: '',), 
      },
    );
  }
}
