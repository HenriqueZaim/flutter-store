import 'package:flutter/material.dart';
import 'package:flutter_app_2/tabs/home_tab.dart';
import 'package:flutter_app_2/tabs/orders_tab.dart';
import 'package:flutter_app_2/tabs/product_tab.dart';
import 'package:flutter_app_2/widgets/CustomDrawer.dart';
import 'package:flutter_app_2/widgets/cart_button.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus pedidos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: OrdersTab(),
        )
      ],
    );
  }
}
