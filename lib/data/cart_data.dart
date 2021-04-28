

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/product_data.dart';
import 'package:delivery_app/models/user_model.dart';

class CartData {

  String idSupplier = "";
  List<ProductData> products = [];

  static final CartData _instance = CartData._();

  factory CartData() => _instance;

  CartData._ ();

  int addProduct(String id, ProductData productData) {
    bool exists = false;
    if (this.idSupplier == ""){
      this.idSupplier = productData.idSupplier;
    }
    if (this.idSupplier != productData.idSupplier) {
      return -1;
    } else {
      products.forEach((productData) {
        if (productData.idProduct == id){
          exists = true;
        }
      });
      if (exists){
        products.removeWhere((element) => element.idProduct == productData.idProduct);
      }
      products.add(productData);
      return 0;
    }
  }

  void removeProduct(String id) {
      products.removeWhere((element) => element.idProduct == id);
  }

  void clear() {
    products.clear();
    this.idSupplier = "";
  }
  Future<String> finishOrder(String idClient,String idSupplier) async {
    double productsPrice = getAmountPrice(this.products);
    double deliveryPrice = getDeliveryPrice();
    DocumentReference refOrder = await Firestore.instance.collection("orders").add(
      {
        "clientId":idClient,
        "supplierId": idSupplier,
        //"productsQuantity": products.map((product)=>{product.idProduct: product.un}).toList(),
        "products": products.map((product) => {
          "idProduct": product.idProduct,
          "idSupplier" : product.idSupplier,
          "image": product.image,
          "name": product.name,
          "price": product.price,
          "un": product.un,
        }).toList(),
        "productsTotalPrice": productsPrice,
        "deliveryPrice": deliveryPrice,
        "totalPrice": productsPrice + deliveryPrice,
        "dateOrder": DateTime.now(),
        "status": 1
      });
      return refOrder.documentID;
  }
  double getAmountPrice(List<ProductData> productData){
    double amountPrice = 0;
    productData.forEach((product) {
      amountPrice += product.price * product.un;
     });
     return amountPrice;
  }
  double getDeliveryPrice(){
    return 5.5;
  }
}
