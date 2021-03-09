import 'package:flutter/material.dart';
import 'package:flutter_app_2/models/cart_model.dart';
import 'package:flutter_app_2/models/user_model.dart';
import 'package:flutter_app_2/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant(
        builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  primaryColor: Color.fromARGB(255, 127, 5, 118)
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        },
      )
    );
  }
}


