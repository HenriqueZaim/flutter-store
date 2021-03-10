import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_2/datas/cart_product_data.dart';
import 'package:flutter_app_2/models/user_model.dart';

class CartModel with ChangeNotifier{

  UserModel user;
  List<CartProductData> products = [];

  CartModel(this.user);

  void addItem(CartProductData cartProductData){
    products.add(cartProductData);

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
      .collection("cart").add(cartProductData.toMap())
        .then((value) {
          cartProductData.cart_id = value.documentID;
        });

    notifyListeners();
  }

  void removeItem(CartProductData cartProductData){
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cartProductData.cart_id).delete();

    products.remove(cartProductData);
    notifyListeners();
  }
}