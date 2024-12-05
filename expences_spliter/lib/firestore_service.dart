import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
  Future<String?> register(String email, String password, Map<String, dynamic> userData) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      await _db.collection('users').doc(uid).set(userData);

      return "Rejestration was successful";

    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


}