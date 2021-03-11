
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_2/datas/product_data.dart';

class CartProductData {

  String uid;
  String category;
  String product_id;
  String processor;

  int quantity;

  ProductData productData;

  CartProductData();

  CartProductData.fromDocument(DocumentSnapshot documentSnapshot){
    uid = documentSnapshot.documentID;
    category = documentSnapshot.data["category"];
    product_id = documentSnapshot.data["product_id"];
    quantity = documentSnapshot.data["quantity"];
    processor = documentSnapshot.data["processor"];
  }

  Map<String, dynamic> toMap(){
    return {
      "category": category,
      "processor": processor,
      "quantity": quantity,
      "product_id": product_id
    };
  }
}