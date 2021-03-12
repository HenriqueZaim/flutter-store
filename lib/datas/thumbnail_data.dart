import 'package:cloud_firestore/cloud_firestore.dart';

class ThumbnailData {
  String uid;
  String image;
  int pos;
  int x;
  int y;

  ThumbnailData();

  ThumbnailData.fromDocument(DocumentSnapshot snapshot){
    uid = snapshot.documentID;
    image = snapshot.data["image"];
    pos = snapshot.data["pos"];
    x = snapshot.data["x"];
    y = snapshot.data["y"];
  }

  Map<String, dynamic> toMap(){
    return {
      "image": image,
      "pos": pos,
      "x": x,
      "y": y
    };
  }

  ThumbnailData.fromMap(Map<String, dynamic> item){
    uid = item["uid"];
    image = item["image"];
    pos = item["pos"];
    x = item["x"];
    y = item["y"];
  }

}