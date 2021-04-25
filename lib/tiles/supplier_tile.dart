import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/screens/supplier_screen.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class SupplierTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const SupplierTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>SupplierScreen(snapshot))
        );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${snapshot.data["name"]}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Distância: TO-DO",
                    style: TextStyle(fontSize: 15),
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Avaliação: ${snapshot.data["rate"]}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                      ),
                    ],
                  ),
                  Text(
                    "${snapshot.data["sales"]} vendas efetuadas",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Expanded(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: snapshot.data["image"],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
