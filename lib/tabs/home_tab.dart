import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {

  PageController controller;

  HomeTab(this.controller);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        ListView(
          padding: EdgeInsets.all(30),
          children: [
            FutureBuilder<QuerySnapshot>(
                future: Firestore.instance.collection("home").getDocuments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    String urlLogo = snapshot.data.documents.first.data["logo"];
                    return FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: urlLogo,
                      height: 300,
                    );
                  }
                }),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Bem vindo ao Pida-lá",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(padding: EdgeInsets.all(40)),
            Container(
              child: Column(
                children: <Widget>[            
                  // ignore: deprecated_member_use
                  RaisedButton(
                    padding: EdgeInsets.all(10.0),
                    color: Theme.of(context).primaryColor,
                    elevation: 4.0,
                    splashColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Fazer um Pedido",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Icon(
                          Icons.shopping_cart,
                        )
                      ],
                    ),
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    padding: EdgeInsets.all(10.0),
                    color: Theme.of(context).primaryColor,
                    elevation: 4.0,
                    splashColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Meus Pedidos",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Icon(
                          Icons.playlist_add_check,
                        )
                      ],
                    ),
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    padding: EdgeInsets.all(10.0),
                    color: Theme.of(context).primaryColor,
                    elevation: 4.0,
                    splashColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    onPressed: () {
                      this.controller.jumpToPage(1);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Configurações",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Icon(
                          Icons.settings,
                        )
                      ],
                    ),
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    padding: EdgeInsets.all(10.0),
                    color: Theme.of(context).primaryColor,
                    elevation: 4.0,
                    splashColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Sair do App",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Icon(
                          Icons.logout,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
