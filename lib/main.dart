import 'package:flutter/material.dart';
import 'package:flutter_app_2/models/cart_model.dart';
import 'package:flutter_app_2/models/product_model.dart';
import 'package:flutter_app_2/models/user_model.dart';
import 'package:flutter_app_2/screens/home_screen.dart';
import 'package:flutter_app_2/sqflite/DatabaseConfig.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final dbConfig = DatabaseConfig.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThumbnailModel>(create: (BuildContext context) => ThumbnailModel(dbConfig)),
        ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
        ChangeNotifierProxyProvider<UserModel, CartModel>(
          update: (context, user, previousCart) => CartModel(user, dbConfig),
          create: (BuildContext context) => CartModel(null, dbConfig),
        ),
      ],
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
  }
}


