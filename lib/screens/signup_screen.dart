import 'package:flutter/material.dart';
import 'package:flutter_app_2/models/user_model.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: (){},
            child: Text(
              "ENTRAR",
              style: TextStyle(
                  fontSize: 15.0
              ),
            ),
            textColor: Colors.white,

          )
        ],
      ),
      body: Consumer<UserModel>(
        builder: (_, model, __) {
          if(model.isLoading)
            return Center(child: CircularProgressIndicator());

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: "Nome completo"
                  ),
                  validator: (text) {
                    if(text.isEmpty) return "Nome inválido";
                  },
                ),
                SizedBox(height: 16.0),
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
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      hintText: "Endereço"
                  ),
                  validator: (text){
                    if(text.isEmpty) return "Endereço inválido";
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
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
                      model.signUp(
                          userData: {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "address": _addressController.text
                          },
                          password: _passwordController.text,
                          onSuccess: _onSuccess,
                          onFailure: _onFail
                      );
                    }
                  },
                  child: Text(
                    "Criar conta",
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
        },
      ),
    );
  }

  void _onSuccess(){

    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuário cadastrado com sucesso!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      )
    );

    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Houve um erro ao tentar cadastrar."),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        )
    );
  }
}
