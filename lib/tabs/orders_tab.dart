import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/models/user_model.dart';
import 'package:flutter_app_2/screens/login_screen.dart';
import 'package:flutter_app_2/tiles/order_tile.dart';
import 'package:provider/provider.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (_, model, __){

        if(model.isLoggedIn()){
          String uid = model.firebaseUser.uid;

          return FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection("users").document(uid).collection("orders").getDocuments(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator()
                );
              }else{
                return ListView(
                  children: snapshot.data.documents.map((e) => OrderTile(e.documentID)).toList(),
                );
              }
            },
          );
        }else{
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.list,
                color: Theme.of(context).primaryColor,
                size: 80.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Faça login para visualizar seus pedidos",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              MaterialButton(
                child: Text("Entrar"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen())
                  );
                },
              )
            ],
          ));
        }
      },
    );
  }
}
