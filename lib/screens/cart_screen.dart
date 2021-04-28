import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/cart_data.dart';
import 'package:delivery_app/models/user_model.dart';
import 'package:delivery_app/tiles/cart_tile.dart';
import 'package:delivery_app/tiles/resume_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartData cartData = CartData();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Meu carrinho"),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          if (cartData.products.length == 0) {
            cartData.clear();
            return Center(
              child: Text("Carrinho Vazio"),
            );
          } else {
            return ListView(
              padding: EdgeInsets.all(10),
              children: [
                Column(
                    children: cartData.products
                        .map((product) => CartTile(product, attFunction))
                        .toList()),
                ResumeTile(cartData.products),
                RaisedButton(
                  onPressed: () async {
                    String idOrder = await cartData.finishOrder(UserModel.of(context).firebaseUser.uid, cartData.idSupplier);
                    if (idOrder.isNotEmpty){
                      cartData.clear();
                      _showSucessOrder(idOrder);
                    } else{
                      _showFailOrder();
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Text(
                    UserModel.of(context).isLoggedIn()
                        ? "Finalizar Compra"
                        : "Entre para comprar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: UserModel.of(context).isLoggedIn()
                      ? Colors.green
                      : Colors.grey,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _showSucessOrder(String idOrder){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Pedido recebido com o ID: ${idOrder}", style: TextStyle(fontSize: 18),),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }
   void _showFailOrder(){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Pedido não efetuado, tente novamente", style: TextStyle(fontSize: 18),),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void attFunction() {
    setState(() {});
  }
}
