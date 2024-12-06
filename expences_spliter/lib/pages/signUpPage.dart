// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expences_spliter/firestore_service.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {

  final FirestoreService _firestoreService = FirestoreService();

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
                    //controller: ,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                       border: OutlineInputBorder()
                    )
                  ),

                   const SizedBox(height: 12),

                   // age field
                   TextField(
                     //controller: ,
                     decoration: const InputDecoration(
                       labelText: 'Age',
                       border: OutlineInputBorder()
                     )
                   ),

                   const SizedBox(height: 12),

                   // email field
                  TextField(
                    //controller: ,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder()
                    )
                  ),

                  const SizedBox(height: 12),

                   // password field
                   TextField(
                    //controller: ,
                    decoration: const InputDecoration(
                       labelText: 'Password',
                       border: OutlineInputBorder()
                    )
                  ),

                  const SizedBox(height: 12),

                  // password second field
                  TextField(
                     //controller: ,
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
                            color: Colors.teal,
                          ) 
                        )
                      ),

                      // button signing
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