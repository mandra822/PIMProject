// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expences_spliter/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  
  final FirestoreService _firestoreService = FirestoreService();

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void registerUser() async {
    String email = "user@example.com";
    String password = "password123";

    // Dodatkowe dane użytkownika
    Map<String, dynamic> userData = {
      "name": "John Doe",
      "age": 30,
      "email": email,
    };

    String? result = await _firestoreService.register(email, password, userData);

    if (result.toString() == "success") {
      print("New User Added");
    } else {
      print("Registration failed: $result");
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          // title section
          Container(
            color: const Color(0xFF76BBBF),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Text(
                    'Expences Splitter',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    )
                  ),

                  Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    )
                  ),

                ]
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

                  // email field
                  TextField(
                    controller: _loginController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
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
                  ),

                  const SizedBox(height: 12),

                  const Divider(),

                  const SizedBox(height: 12),

                  // button sign up
                      ElevatedButton(
                        onPressed: () {
                          //registerUser();
                        }, 
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'or SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                          ) 
                        )
                      ),

                ],
              )
            )
          ),
        ]
      )
    );
  }

}