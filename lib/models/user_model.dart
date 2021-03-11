
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserModel with ChangeNotifier{

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  @override
  void addListener(listener) {
    // TODO: implement addListener
    super.addListener(listener);
    _loadCurrentUser();
  }

  void signUp({ @required Map<String, dynamic> userData, @required String password, @required VoidCallback onSuccess, @required VoidCallback onFailure}){
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: password
    ).then((user) async {
      firebaseUser = user;
      onSuccess();

      await _saveUserData(userData);

      isLoading = false;
      notifyListeners();

    }).catchError((e) {
      onFailure();

      isLoading = false;
      notifyListeners();
    });
  }

  void signIn({ @required String email, @required String password, @required VoidCallback onSuccess, @required VoidCallback onFailure}) async {
    isLoading = true;
    notifyListeners();

    await _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
          firebaseUser = value;

          await _loadCurrentUser();

          onSuccess();
          isLoading = false;
          notifyListeners();

        }).catchError((e) {
          onFailure();
          isLoading = false;
          notifyListeners();
        });
  }

  void recoverPassword(String email){
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    else{
      if(userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance.collection("users").document(firebaseUser.uid).get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }

}