import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/datas/product_data.dart';
import 'package:flutter_app_2/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                snapshot.data["category"] ?? "null",
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list_outlined),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection("products")
                .document(snapshot.documentID).collection("desktops")
                .getDocuments(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator());
              }else{
                return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                        padding: EdgeInsets.all(5.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 0.80
                        ),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                          data.category = this.snapshot.documentID;
                          return ProductTile(
                              "grid",
                              data
                          );
                        },
                      ),
                      ListView.builder(
                        padding: EdgeInsets.all(5.0),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                          data.category = this.snapshot.documentID;

                          return ProductTile(
                            "list",
                            data
                          );
                        },
                      )
                    ]
                );
              }
            },
          )
        )
    );
  }
}
