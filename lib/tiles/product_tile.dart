import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app_2/datas/product_data.dart';
import 'package:flutter_app_2/screens/product_screen.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProductScreen(product))
        );
      },
      child: Card(
        child: type == "grid"
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.3,
                  child: Image.network(
                    product.images[0] ?? "http://bppl.kkp.go.id/uploads/publikasi/karya_tulis_ilmiah/default.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "R\$ ${product.price.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17.0,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
          )
          : Row(
            children: [
              Flexible(
                flex: 1,
                child: Image.network(
                  product.images[0] ?? "http://bppl.kkp.go.id/uploads/publikasi/karya_tulis_ilmiah/default.jpg",
                  fit: BoxFit.contain,
                  height: 250.0,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "R\$ ${product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}
