import 'package:flutter/material.dart';
import 'package:flutter_app_2/models/user_model.dart';
import 'package:flutter_app_2/screens/login_screen.dart';
import 'package:flutter_app_2/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 114, 0, 196),
                Color.fromARGB(255, 210, 0, 210),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 0.0),
                height: 170.0,
                child: Stack(
                  children: [
                    Positioned(
                      child: Text(
                        "App Store test",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 38.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      top: 8.0,
                      left: 0.0,
                    ),
                    Positioned(
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Olá, ${model.userData["name"] ?? ""}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white70
                                ),
                              ),
                              SizedBox(height: 10.0),
                              GestureDetector(
                                child: Text(
                                  "${!model.isLoggedIn() ? "Entre ou cadastre-se" : "Sair"}",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                                onTap: () {
                                  if(!model.isLoggedIn()){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => LoginScreen())
                                    );
                                  }else{
                                    model.signOut();
                                  }

                                },
                              )
                            ],
                          );
                        },
                      ),
                      left: 0.0,
                      bottom: 0.0,
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus pedidos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}
