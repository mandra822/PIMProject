// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expences_spliter/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  
  final FirestoreService _firestoreService = FirestoreService();

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          
          // title section
          Container(
            color: const Color(0xFF76BBBF),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
              child: Text(
                'Expences Splitter',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                )
              )
            )
          ),

          // login section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // login field
                  TextField(
                    controller: _loginController,
                    decoration: const InputDecoration(
                      labelText: 'Login',
                      border: OutlineInputBorder()
                    )
                  ),

                  const SizedBox(height: 12),

                  // password field
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder()
                    ),
                    obscureText: true
                  ),

                  const SizedBox(height: 24),

                  // bottons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // button cancel
                      ElevatedButton(
                        onPressed: () {
                          // cancel button functionality
                        }, 
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: null
                        ),
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(
                            color: Colors.blue,
                          ) 
                        )
                      ),

                      // button login
                      ElevatedButton(
                        onPressed: () {
                          _firestoreService.getPassword(_loginController.text);
                          // _checkPassword();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: null
                        ),
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(
                            color: Colors.blue,
                          )
                        )
                      )
                    ]
                  )
                ],
              )
            )
          )
        ]
      )
    );
  }

}