import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  // 1
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _collectionReference;

  AuthenticationService(this._firebaseAuth, this._collectionReference);

  // 2
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // 3
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

  // 4
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

  // 5
  Future<String?> completeProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      await _collectionReference.add({
        "uid": _firebaseAuth.currentUser!.uid,
        "username": "$firstName $lastName",
        "phoneNumber": phoneNumber,
        "address": address,
        "favorites": [],
      });
      return "Profile completed";
    } on StateError catch (e) {
      return e.message;
    }
  }

  // 6
  Future<String?> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Signed out";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // 7
  User? getUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }
}
