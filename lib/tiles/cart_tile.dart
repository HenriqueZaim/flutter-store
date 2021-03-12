import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/datas/cart_product_data.dart';
import 'package:flutter_app_2/datas/product_data.dart';
import 'package:flutter_app_2/models/cart_model.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartProductData cartProductData;

  CartTile(this.cartProductData);

  Widget _buildContent(BuildContext context){

    return Consumer<CartModel>(
      builder: (_, cartModel, __) {
        cartModel.updatePrices();
        return Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              width: 120.0,
              child: Image.network(
                cartProductData.productData.images[0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cartProductData.productData.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0
                      ),
                    ),
                    Text(
                      "Processador: ${cartProductData.processor}",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "R\$${cartProductData.productData.price.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(icon: Icon(Icons.remove), onPressed: cartProductData.quantity > 1 ? (){
                          cartModel.updateQtty(cartProductData, -1);
                        } : null),
                        Text(cartProductData.quantity.toString()),
                        IconButton(icon: Icon(Icons.add), onPressed: (){
                          cartModel.updateQtty(cartProductData, 1);
                        }),
                        TextButton(onPressed: (){
                          cartModel.removeItem(cartProductData);
                        }, child: Text("Remover", style: TextStyle(color: Colors.black45)))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );


  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartProductData.productData == null
        ? FutureBuilder<DocumentSnapshot>(
            future: Firestore.instance.collection("products").document(cartProductData.category).collection("desktops").document(cartProductData.product_id).get(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                cartProductData.productData = ProductData.fromDocument(snapshot.data);
                return _buildContent(context);
              }else{
                return Container(
                  height: 70.0,
                  child: CircularProgressIndicator(),
                  alignment: Alignment.center,
                );
              }
            },
          )
        : _buildContent(context)
    );
  }
}
