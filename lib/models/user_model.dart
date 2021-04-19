import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {
  
  FirebaseAuth _auth = FirebaseAuth.instance; //Singleton

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  Future<void> signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();
    try {
      await _auth.createUserWithEmailAndPassword(
          email: userData["email"], password: pass);
      firebaseUser = await _auth.currentUser() as FirebaseUser ;
      await _saveUserData(userData);
      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString()+"bilbo\n");
      onFail();
      isLoading = false;
      notifyListeners();
    }
  }

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("eu\n\n"+e.toString());
      onFail();
      isLoading = false;
      notifyListeners();
    }
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      DocumentSnapshot docUser = await Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .get();
        this.userData = docUser.data;
    }
    notifyListeners();
  }
}
