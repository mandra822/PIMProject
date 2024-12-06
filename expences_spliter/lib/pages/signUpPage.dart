// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expences_spliter/firestore_service.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {

  final FirestoreService _firestoreService = FirestoreService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();

  void _showInfo(BuildContext context, String message) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('INFO'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            child: Text('OK')
          )
        ],
      )
    );
  }

  void _registerUser(String email, String password, String name, int age, BuildContext context) async {

    // Dodatkowe dane użytkownika
    Map<String, dynamic> userData = {
      "name": name,
      "age": age,
      "email": email,
    };

    String? result = await _firestoreService.register(email, password, userData);

    if (result.toString() == "success") {
      _showInfo(context, "New User Added");
    } else {
      _showInfo(context, "Registration failed: $result");
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          // title section
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

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
                    'Sign Up',
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

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // name field
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                       border: OutlineInputBorder()
                    )
                  ),

                   const SizedBox(height: 12),

                   // age field
                   TextField(
                     controller: _ageController,
                     decoration: const InputDecoration(
                       labelText: 'Age',
                       border: OutlineInputBorder()
                     )
                   ),

                   const SizedBox(height: 12),

                   // email field
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder()
                    )
                  ),

                  const SizedBox(height: 12),

                   // password field
                   TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                       labelText: 'Password',
                       border: OutlineInputBorder()
                    )
                  ),

                  const SizedBox(height: 12),

                  // password second field
                  TextField(
                     controller: _repeatController,
                     obscureText: true,
                     decoration: const InputDecoration(
                       labelText: 'Repeat password',
                       border: OutlineInputBorder()
                     )
                   ),

                   const SizedBox(height: 24),

                   // bottons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // button cancel
                      ElevatedButton(
                        onPressed: () {
                          _nameController.clear();
                          _ageController.clear();
                          _emailController.clear();
                          _passwordController.clear();
                          _repeatController.clear();
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
                            color: Colors.teal,
                          ) 
                        )
                      ),

                      // button signing
                      ElevatedButton(
                        onPressed: () {
                          int? age = int.tryParse(_ageController.text);
                          if (age == null) {
                            _showInfo(context, "Incorrect age format - not a number");
                          }
                          else {
                            String password = _passwordController.text;
                            String repeat = _repeatController.text;
                            if (password != repeat) {
                              _showInfo(context, "Repeated password is not the same as the first one!");
                            }
                            else {
                              _registerUser(_emailController.text, password, _nameController.text, age, context);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: null
                        ),
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.teal,
                          )
                        )
                      )
                    ]
                  ),

                  const SizedBox(height: 12),

                  const Divider(),

                  const SizedBox(height: 12),

                  // button back to login page
                      ElevatedButton(
                        onPressed: () {
                          
                        }, 
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: const Color(0xFF76BBBF),
                        ),
                        child: const Text(
                          'or SIGN IN',
                          style: TextStyle(
                            color: Colors.white,
                          ) 
                        )
                      ),

                 ]
              )
             )
          )
          
        ],
      )
    );
  }

}