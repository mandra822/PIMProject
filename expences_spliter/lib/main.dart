import 'package:expences_spliter/pages/balance.dart';
import 'package:expences_spliter/pages/home.dart';
import 'package:expences_spliter/pages/loginPage.dart';
import 'package:expences_spliter/pages/signUpPage.dart';
import 'package:expences_spliter/pages/singleGroup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class GroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Groups")),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('groups').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No groups available"));
          }

          final groups = snapshot.data!.docs;

          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final groupId = groups[index].id;
              return ListTile(
                title: Text(groups[index]['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleGroup(groupId: groupId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
