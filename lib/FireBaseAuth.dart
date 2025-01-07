
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final FirebaseAuth _Firebaseauth=FirebaseAuth.instance;
  User? get CurrentUser=>_Firebaseauth.currentUser;
  Stream<User?> get authStateChanges=>_Firebaseauth.authStateChanges();
  Future<UserCredential?> signInWithEmailAndPass({
    required String email,
    required String pass})async {
    try{
      final User=await _Firebaseauth.signInWithEmailAndPassword(email: email, password: pass);
      return User;
    }
    catch(e){
      log("Something Went Wrong");
      return null;
    }

  }

  Future<UserCredential?> createUserWithEmailAndPass({
    required String email,
    required String pass})async{
    try{
      final User=await _Firebaseauth.createUserWithEmailAndPassword(email: email, password: pass);
      return User;
    }
    catch(e){
      log("Something Went Wrong.");
      return null;
    }

  }

  Future<void> signout()async{
    try{
      _Firebaseauth.signOut();
    }
    catch(e){
      log("Something Went Wrong.");
    }

  }
}