import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String idSupplier;
  String idProduct;
  String name;
  double price;
  int un;
  String image;
  ProductData.fromDocument(DocumentSnapshot snapshot, idSupplier, un){
    this.idSupplier = idSupplier;
    this.idProduct = snapshot.documentID;
    this.name = snapshot.data["title"];
    this.price = double.parse(snapshot.data["price"]);
    this.un = un;
    this.image = snapshot.data["image"];
  }

}