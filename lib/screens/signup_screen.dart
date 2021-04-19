import 'package:brasil_fields/brasil_fields.dart';
import 'package:delivery_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();
  final _complementController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _numberController = TextEditingController();
  final _cepController = TextEditingController();
  final _telController = TextEditingController();
  final _cpfController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastre-se"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(30),
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Nome Completo"),
                    validator: (text) {
                      if (text.isEmpty) return "Nome Inválido!";
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  TextFormField(
                    controller: _cpfController,
                    decoration: InputDecoration(hintText: "CPF"),
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text.isEmpty || text.length != 14)
                        return "CPF inválido";
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail inválido!";
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha inválida!";
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  TextFormField(
                    controller: _telController,
                    decoration: InputDecoration(hintText: "Telefone"),
                    keyboardType: TextInputType.phone,
                    validator: (text) {
                      if (text.isEmpty) return "E-mail inválido!";
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _stateController,
                          decoration: InputDecoration(hintText: "Estado"),
                          validator: (text) {
                            if (text.isEmpty) return "Estado inválido!";
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _cityController,
                          decoration: InputDecoration(hintText: "Cidade"),
                          validator: (text) {
                            if (text.isEmpty) return "Cidade inválida!";
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(hintText: "Enereço"),
                    validator: (text) {
                      if (text.isEmpty) return "Endereço inválida!";
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  TextFormField(
                    controller: _complementController,
                    decoration:
                        InputDecoration(hintText: "Complemento (Opcional)"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _numberController,
                          decoration: InputDecoration(hintText: "Número"),
                          keyboardType: TextInputType.number,
                          validator: (text) {
                            if (text.isEmpty) return "Número inválido!";
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _cepController,
                          decoration: InputDecoration(hintText: "CEP"),
                          keyboardType: TextInputType.number,
                          validator: (text) {
                            if (text.isEmpty || text.length != 10)
                              return "CEP invalido!";
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter()
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text(
                        "Criar conta",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "cpf": _cpfController.text,
                            "tel": _telController.text,
                            "state": _stateController.text,
                            "city": _cityController.text,
                            "address": _addressController.text,
                            "num": _numberController.text,
                            "cep": _cepController.text,
                            "comp": _complementController.text,
                          };

                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar usuário!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
