import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderScreen extends StatelessWidget {
  final String orderID;
  const OrderScreen(this.orderID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informações do pedido"),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection("orders")
            .document(this.orderID)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Sem dados para este pedido"),
            );
          } else {
            return StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection("delivery")
                    .document(snapshot.data["deliveryId"])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Sem dados para este entregador"),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(30),
                              child: Image.asset(
                                "images/maps.jpeg",
                                fit: BoxFit.cover,
                                height: 300.0,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(70)),
                              child: Container(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  "nothng",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "Seu pedido chegará em TO-DO",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Nome: Mome",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Telefone: ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Avaliação: ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                child: Text(
                                  "Ligar para o entregador",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                color: Colors.blue,
                                onPressed: () {
                                  launch(
                                      "tel://88582471"); //Para abrir a ligação Padrão do cell
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                });
          }
        },
      ),
    );
  }
}
