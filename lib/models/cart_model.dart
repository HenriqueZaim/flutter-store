import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_2/datas/cart_product_data.dart';
import 'package:flutter_app_2/models/user_model.dart';

class CartModel with ChangeNotifier{

  UserModel user;
  List<CartProductData> products = [];

  bool isLoading = false;

  CartModel(this.user) {
    if(this.user != null && this.user.isLoggedIn()) {
      getItens(user_uid: this.user.firebaseUser.uid);
    }
  }

  void getItens({@required String user_uid}) async {
    this.isLoading = true;
    notifyListeners();

    QuerySnapshot data = await Firestore.instance.collection('users')
        .document(user_uid)
        .collection("cart").getDocuments();

    products = data.documents.map((item){
      return CartProductData.fromDocument(item);
    }).toList();

    this.isLoading = false;
    notifyListeners();
  }

  void addItem(CartProductData cartProductData){
    this.isLoading = true;
    notifyListeners();

    products.add(cartProductData);
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
      .collection("cart").add(cartProductData.toMap())
        .then((value) {
          cartProductData.uid = value.documentID;
        });

    this.isLoading = false;
    notifyListeners();
  }

  void removeItem(CartProductData cartProductData){
    this.isLoading = true;
    notifyListeners();

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cartProductData.uid).delete();

    products.remove(cartProductData);
    notifyListeners();

    this.isLoading = false;
    notifyListeners();
  }

  void updateQtty(CartProductData cartProductData, int value){
    cartProductData.quantity += value;

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
      .document(cartProductData.uid).updateData(cartProductData.toMap());

    notifyListeners();
  }
}