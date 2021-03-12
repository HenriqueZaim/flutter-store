import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_2/datas/cart_product_data.dart';
import 'package:flutter_app_2/models/user_model.dart';
import 'package:flutter_app_2/sqflite/DatabaseConfig.dart';

class CartModel with ChangeNotifier{
  bool isLoading = false;
  String couponCode;
  int discountPercentage = 0;

  UserModel user;
  List<CartProductData> products = [];

  final DatabaseConfig _db;
  static final _table = "carts";

  CartModel(this.user, this._db) {
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

    if(data != null){
      products = data.documents.map((item){
        var cart = CartProductData.fromDocument(item);
        _db.insert(cart.toMap(), _table);

        return cart;
      }).toList();
    }else{
      _db.queryAllRowsByUid(_table, { "user_id": user_uid })
        .then((value) {
          print("ok");
        });
    }

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

  void setCoupon(String couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  double getProductsPrice(){
    double price = 0.0;
    for(CartProductData c in products){
      if(c.productData != null)
        price += c.quantity * c.productData.price;
    }
    return price;
  }

  double getDiscount(){
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice(){
    return 9.99;
  }

  void updatePrices(){
    notifyListeners();
  }

  Future<String> finishOrder() async {
    if(products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder = await Firestore.instance.collection("orders").add(
      {
        "clientId": user.firebaseUser.uid,
        "products": products.map((e) => e.toMap()).toList(),
        "shipPrice": shipPrice,
        "productsPrice": productsPrice,
        "discount": discount,
        "totalPrice": productsPrice - discount + shipPrice,
        "status": 1
      }
    );

    await Firestore.instance.collection("users").document(user.firebaseUser.uid)
      .collection("orders").document(refOrder.documentID).setData({
      "orderId": refOrder.documentID
    });

    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid)
      .collection("cart").getDocuments();

    for(DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }

    products.clear();

    couponCode = null;
    discountPercentage = 0;

    isLoading = false;
    notifyListeners();

    return refOrder.documentID;
  }

  void updateQtty(CartProductData cartProductData, int value){
    cartProductData.quantity += value;

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
      .document(cartProductData.uid).updateData(cartProductData.toMap());

    notifyListeners();
  }
}