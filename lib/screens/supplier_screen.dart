import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class SupplierScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const SupplierScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escolha produtos de ${snapshot.data["name"]}"),
        centerTitle: true,
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
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Card(
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
                          Expanded(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: snapshot.data.documents[index].data["image"],
                            ),
                          ),
                        ],
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
