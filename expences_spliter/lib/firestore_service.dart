import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //method to register new users
  Future<String?> register(String email, String password, Map<String, dynamic> userData) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      await _db.collection('users').doc(uid).set(userData);

      return "success";

    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //method to log in users
  Future<String?> logIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return "success";

    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }




}