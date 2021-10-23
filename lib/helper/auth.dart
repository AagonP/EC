import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  // Static variables for authentication
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _usersReference =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference _ordersReference =
      FirebaseFirestore.instance.collection("orders");

  AuthenticationService();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign in
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign up
  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Complete profile
  Future<String?> completeProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      String uid = getUser()!.uid;
      await _usersReference.doc(uid).set({
        "username": "$firstName $lastName",
        "phoneNumber": phoneNumber,
        "address": address,
        "favorites": [],
      });
      await _ordersReference.doc(uid).set({
        "expire_time": "",
        "total": "0.00",
        "store_id": "",
      });
      await _ordersReference
          .doc(uid)
          .collection("foods")
          .doc("no_item")
          .set({"no_item": "0"});
      return "Profile completed";
    } on StateError catch (e) {
      return e.message;
    }
  }

  // Sign out
  Future<String?> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Signed out";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Get user
  User? getUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }
}
