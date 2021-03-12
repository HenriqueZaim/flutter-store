import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_2/models/cart_model.dart';
import 'package:provider/provider.dart';

class DiscountCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CartModel model = Provider.of<CartModel>(context);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom"
              ),
              initialValue: model.couponCode ?? "",
              onFieldSubmitted: (text){
                Firestore.instance.collection("coupons").document(text).get().then((value){
                  if(value.data != null){
                    model.setCoupon(text, value.data["percent"]);
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Desconto de ${value.data["percent"]}% aplicado"),
                          backgroundColor: Theme.of(context).primaryColor,)
                    );
                  }else{
                    model.setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Cupom não existente"),
                      backgroundColor: Colors.redAccent,)
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
