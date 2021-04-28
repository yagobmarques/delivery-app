import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/cart_data.dart';
import 'package:delivery_app/data/product_data.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CartTile extends StatefulWidget {
  final ProductData productData;
  final dynamic attFunction;
  const CartTile(this.productData, this.attFunction);


  @override
  _CartTileState createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.productData.name}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.productData.price * widget.productData.un}R\$",
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    Text(
                      "R\$${widget.productData.price} x ${widget.productData.un}",
                      style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                    ),
                  ],
                ),
                Flexible(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.productData.image,
                    height: 120,
                  ),
                ),
              ],
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {
                  CartData().removeProduct(widget.productData.idProduct);
                  widget.attFunction();
              },
              child: Text(
                "Remover",
                style: TextStyle(color: Colors.red),
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
