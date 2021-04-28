import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/cart_data.dart';
import 'package:delivery_app/data/product_data.dart';
import 'package:delivery_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductScreen extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final String id;
  ProductScreen(this.snapshot, this.id);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int un = 1;
  CartData cartData = CartData();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("${widget.snapshot.data["title"]}"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: "${widget.snapshot.data["image"]}"),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 30)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nome do Produto:",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "${widget.snapshot.data["title"]}",
                        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    Text(
                      "Descrição: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "${widget.snapshot.data["description"]}",
                        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    Text(
                      "Valor:",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "R\$ ${widget.snapshot.data["price"]}",
                        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 50,
                icon: Icon(
                  Icons.remove_circle_sharp,
                  color: Colors.red,
                  size: 50,
                ),
                onPressed: () {
                  setState(() {
                    if (un > 1) {
                      un--;
                    }
                  });
                },
              ),
              Text(
                "$un",
                style: TextStyle(fontSize: 50, color: Colors.blueGrey),
              ),
              IconButton(
                  iconSize: 50,
                  icon: Icon(Icons.add_circle_sharp, color: Colors.green),
                  onPressed: () {
                    setState(() {
                      un++;
                    });
                  }),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          RaisedButton(
              onPressed: () {
                setState(() {
                  int status = cartData.addProduct(
                      widget.snapshot.documentID, ProductData.fromDocument(widget.snapshot, widget.id, un));
                  if (status == -1) {
                    _onFail();
                  }
                  else{
                    _onSucess();
                  }
                  Future.delayed(Duration(seconds: 3)).then((_) {
                    Navigator.pop(context);
                  });
                });
              },
              padding: EdgeInsets.all(10),
              child: Text(
                UserModel.of(context).isLoggedIn()
                    ? "Adicionar ao carrinho"
                    : "Entre para comprar",
                style: TextStyle(fontSize: 25, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              color: UserModel.of(context).isLoggedIn()
                  ? Theme.of(context).primaryColor
                  : Colors.grey),
        ],
      ),
    );
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
          "Produto de fornecedor diferente, por favor, esvazie o carrinho se quiser trocar de fornecedor",
          style: TextStyle(
            fontSize: 15
          ),
          ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
          "Produto adicionado no carrinho",
          style: TextStyle(
            fontSize: 15
          ),
          ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
  }
}
