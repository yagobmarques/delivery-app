import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/screens/cart_screen.dart';
import 'package:delivery_app/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class SupplierScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;
  const SupplierScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    final String id = snapshot.documentID;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Escolha produtos de ${snapshot.data["name"]}"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              CartScreen()));
            },
          ),
      body: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection("providers")
            .document(snapshot.documentID)
            .collection("SaleProducts")
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data.documents.length == 0) {
              return Center(child: Text("Nenhum produto disponivel"));
            }
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 200,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProductScreen(snapshot.data.documents[index], id)));
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
                                "${snapshot.data.documents[index].data["title"]}",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: 219,
                                child: Text(
                                  "${snapshot.data.documents[index].data["description"]}",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blueGrey),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),
                              Text(
                                "R\$${snapshot.data.documents[index].data["price"]}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.blueGrey),
                              ),
                            ],
                          ),
                          Flexible(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: snapshot.data.documents[index].data["image"],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
