
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/datas/thumbnail_data.dart';
import 'package:flutter_app_2/sqflite/DatabaseConfig.dart';

class ThumbnailModel with ChangeNotifier {

  bool isLoading = false;
  List<ThumbnailData> thumbnailDataList;

  final DatabaseConfig _db;
  static final _table = "thumbnails";

  ThumbnailModel(this._db){
    getItens();
  }

  void getItens() async {
    this.isLoading = true;
    notifyListeners();
    QuerySnapshot data;

    try{
      data = await Firestore.instance.collection('home').orderBy("pos").getDocuments();
    }catch(ignore){}
    if(data != null){
      thumbnailDataList = data.documents.map((item){
        var thumb = ThumbnailData.fromDocument(item);
        _db.insert(thumb.toMap(), _table);

        return thumb;
      }).toList();
    }else{
      _db.queryAllRows(_table).then((value) {
        if(value.isNotEmpty){
          thumbnailDataList = value.map((e) {
            return ThumbnailData.fromMap(e);
          }).toList();
        }
      });
    }

    this.isLoading = false;
    notifyListeners();

  }

}
