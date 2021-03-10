import 'package:flutter/material.dart';
import 'package:flutter_app_2/models/cart_model.dart';
import 'package:flutter_app_2/models/user_model.dart';
import 'package:flutter_app_2/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
        ChangeNotifierProxyProvider<UserModel, CartModel>(
          update: (context, user, previousCart) => CartModel(user),
          create: (BuildContext context) => CartModel(null),
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


