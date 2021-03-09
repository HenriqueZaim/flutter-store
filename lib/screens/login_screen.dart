import 'package:flutter/material.dart';
import 'package:flutter_app_2/models/user_model.dart';
import 'package:flutter_app_2/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignupScreen())
              );
            },
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(
                  fontSize: 15.0
              ),
            ),
            textColor: Colors.white,

          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if(model.isLoading)
              return Center(child: CircularProgressIndicator());

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "E-mail"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@")) return "E-mail inválido";
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: "Senha"
                    ),
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty) return "Senha inválida";
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if(_emailController.text.isEmpty){
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Insira seu e-mail antes de prosseguir."),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                              )
                          );
                        }else{
                          model.recoverPassword(_emailController.text);
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Acesse seu e-mail."),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                              )
                          );
                        }
                      },
                      textColor: Colors.black54,
                      child: Text(
                        "Esqueci a senha",
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor
                        ),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        model.signIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                            onFailure: _onFailure,
                            onSuccess: _onSuccess
                        );
                      }
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            );
          }
      ),
    );
  }

  void _onSuccess(){
    Navigator.of(context).pop();
  }

  void _onFailure(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Houve um erro ao tentar entrar."),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        )
    );
  }
}
