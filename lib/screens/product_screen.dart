import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/datas/cart_product_data.dart';
import 'package:flutter_app_2/datas/product_data.dart';
import 'package:flutter_app_2/models/cart_model.dart';
import 'package:flutter_app_2/models/user_model.dart';
import 'package:flutter_app_2/screens/cart_screen.dart';
import 'package:flutter_app_2/screens/login_screen.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;

  String processor;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final cartModel = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((e) => NetworkImage(e)).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Processador:",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5
                    ),
                    children: product.processors.map((e) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            processor = e;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                              color: e == processor
                                  ? primaryColor
                                  : Colors.black12,
                              width: 2.0
                            )
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(e),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: Consumer<UserModel>(
                    builder: (_, model, __) {
                      return ElevatedButton(
                        onPressed: processor != null
                            ? (){
                                if(model.isLoggedIn()){
                                  CartProductData cartProductData = CartProductData();
                                  cartProductData.category = product.category;
                                  cartProductData.processor = processor;
                                  cartProductData.quantity = 1;
                                  cartProductData.product_id = product.uid;
                                  cartProductData.productData = product;

                                  cartModel.addItem(cartProductData);

                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => CartScreen())
                                  );

                                }else{
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => LoginScreen())
                                  );
                                }
                              }
                            : null,
                        child: Text(
                          model.isLoggedIn()
                              ? "Adicionar ao carrinho"
                              : "Entre para adicionar",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Descrição:",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

