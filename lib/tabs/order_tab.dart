
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/user_model.dart';
import 'package:delivery_app/tiles/order_tile.dart';
import 'package:flutter/material.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("orders").getDocuments(),
      builder: (context, snapshot){
        if (!UserModel.of(context).isLoggedIn()){
          return Center(child: Text("Faça o Login para ver seus pedidos"),);
        }
         else if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        } else if (!verifyOrders(snapshot.data.documents, UserModel.of(context).firebaseUser.uid)){
          return Center(child: Text("Sem pedidos cadastrados"),);
        } else{
          dynamic orderTiles = snapshot.data.documents.map((doc) {
            return OrderTile(doc.documentID);}).toList().reversed.toList();
          return ListView(
            padding: EdgeInsets.all(10),
            children: orderTiles);
        }
      },
    );
  }
  bool verifyOrders(List<DocumentSnapshot> documents, String id){
    bool control = false;
    documents.forEach((doc) {
      if(doc.data["clientId"]== id){
        control = true;
      }
     });
     return control;
  }
}