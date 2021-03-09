
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_2/datas/product_data.dart';

class CartProductData {

  String cart_id;
  String category;
  String product_id;
  String size;

  int quantity;

  ProductData productData;

  CartProductData.fromDocument(DocumentSnapshot documentSnapshot){
    cart_id = documentSnapshot.documentID;
    category = documentSnapshot.data["category"];
    product_id = documentSnapshot.data["product_id"];
    quantity = documentSnapshot.data["quantity"];
    size = documentSnapshot.data["size"];
  }

  Map<String, dynamic> toMap(){
    return {
      "category": category,
      "cart_id": cart_id,
      "product": productData.toResumedMap(),
      "size": size,
      "quantity": quantity
    };
  }
}