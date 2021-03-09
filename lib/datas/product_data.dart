
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;
  String title;
  String description;
  String category;
  double price;
  List images;
  List processors;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    price = snapshot.data["price"] + 0.0;
    images = snapshot.data["images"];
    processors = snapshot.data["processors"];
  }

  Map<String, dynamic> toResumedMap(){
    return {
      "title": title,
      "description": description,
      "price": price + 0.0
    };
  }

}