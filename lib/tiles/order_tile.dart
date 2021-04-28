import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class OrderTile extends StatelessWidget {
  final String orderID;
  const OrderTile(this.orderID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection("orders")
          .document(this.orderID)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          return SizedBox(
            height: 220,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Código do pedido: ${snapshot.data.documentID}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 4.0,),
                    Text("Feito em: ${snapshot.data.data["dateOrder"].toDate()}"),
                    SizedBox(height: 4.0,),
                    Text("Itens: "),
                    SizedBox(height: 4.0,),
                    constructItens(snapshot.data),
                    SizedBox(height: 4.0,),
                    Text("Status do pedido:"),
                    SizedBox(height: 4.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCircle("1", "Aprovando", snapshot.data.data["status"], 1),
                        _buildCircle("2", "Separando Estoque", snapshot.data.data["status"], 2),
                        _buildCircle("3", "Entregador", snapshot.data.data["status"], 3),
                        _buildCircle("4", "Entregue", snapshot.data.data["status"], 4),
                        
                        
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget constructItens(DocumentSnapshot data) {
    List<Row> rows = [];
    for (LinkedHashMap p in data.data["products"]) {
      rows.add(Row(
        children: [
          Text("  ${p["name"]}:     "),
          Text("  ${p["un"]} x "),
          Text("  R\$ ${p["price"]}"),
        ],
      ));
    }
    return Column(children: rows.toList());
  }
  Widget _buildCircle(String title, String subtitle, int status, int thisStatus){

    Color backColor;
    Widget child;

    if(status < thisStatus){
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white),);
    } else if (status == thisStatus){
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.white),),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else if(status == 6){
       backColor = Colors.red;
       child = Icon(Icons.close, color: Colors.white,);
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle)
      ],
    );

  }
}
