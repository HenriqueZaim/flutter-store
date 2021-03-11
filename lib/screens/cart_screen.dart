import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_2/models/cart_model.dart';
import 'package:flutter_app_2/screens/login_screen.dart';
import 'package:flutter_app_2/tiles/cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CartModel model = Provider.of<CartModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Meu carrinho"),
          centerTitle: true,
          actions: model.user.isLoggedIn() ? [
            Container(
              padding: EdgeInsets.only(right: 8.0),
              alignment: Alignment.center,
              child: Text("${model.products.length ?? 0} found"),
            )
          ] : [],
        ),
        body: !model.user.isLoggedIn()
            ? Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.remove_shopping_cart,
                color: Theme.of(context).primaryColor,
                size: 80.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Faça login para adicionar novos produtos",
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
          ))
            : model.isLoading
              ? Center(child: CircularProgressIndicator())
              : model.products.isEmpty || model.products == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.highlight_off, size:60.0, color: Colors.black54),
                        SizedBox(height: 15.0),
                        Text("Não há produtos no carrinho")
                      ],
                    ),
                  )
                : Center(
                    child: ListView(
                      children: model.products.map((item){
                        return CartTile(item);
                      }).toList(),
                    )
                  )

    );
  }
}
