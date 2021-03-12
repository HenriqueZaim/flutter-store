import 'package:flutter/material.dart';
import 'package:flutter_app_2/models/cart_model.dart';
import 'package:flutter_app_2/screens/order_screen.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Consumer<CartModel>(
          builder: (_, model, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Resumo do pedido",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal"),
                    Text("R\$${model.getProductsPrice().toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Desconto"),
                    Text("R\$${model.getDiscount().toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("R\$${(model.getProductsPrice() + model.getShipPrice() - model.getDiscount()).toStringAsFixed(2)}")
                  ],
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  child: Text("Finalizar pedido"),
                  onPressed: () async {
                    String orderId = await model.finishOrder();
                    if(orderId != null){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => OrderScreen(orderId))
                      );
                    }
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
