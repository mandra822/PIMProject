import 'package:expences_spliter/firestore_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  
  final FirestoreService _firestoreService = FirestoreService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  void _logIn(String email, String password, BuildContext context) async {

    if (email.isEmpty || password.isEmpty) {
      _showInfo(context, 'Both email and password are needed to log in!');
      return;
    }

    String? result = await _firestoreService.logIn(email, password);

    if (result == "success") {
      _showInfo(context, "Success! U logged in <3");
      Navigator.pushReplacementNamed(context, '/home'); 
    } 
    else {
      _showInfo(context, 'ERROR: $result');
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
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder()
                    ),
                    obscureText: true
                  ),

                  const SizedBox(height: 24),

                  // buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // button cancel
                      ElevatedButton(
                        onPressed: () {
                          _emailController.clear();
                          _passwordController.clear();
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
                          _logIn(_emailController.text, _passwordController.text, context);
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
                      Navigator.pushNamed(context, '/signUp');
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
