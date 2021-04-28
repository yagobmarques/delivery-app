import 'package:delivery_app/data/cart_data.dart';
import 'package:delivery_app/data/product_data.dart';
import 'package:delivery_app/models/user_model.dart';
import 'package:flutter/material.dart';

class ResumeTile extends StatelessWidget {
  final List<ProductData> productData;
  const ResumeTile(this.productData);

  @override
  Widget build(BuildContext context) {
    double frete = 5.55;
    double subTotal = CartData().getAmountPrice(productData);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text("Detalhes do pedido",
            style: TextStyle(fontSize: 22),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal", style: TextStyle(fontSize: 17),),
              Text("R\$ "+subTotal.toString(), style: TextStyle(fontSize: 17),)
            ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Frete", style: TextStyle(fontSize: 17,)),
              Text("R\$ "+frete.toString(), style: TextStyle(fontSize:17),),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total", style: TextStyle(fontSize: 22,)),
              Text("R\$ ${frete + subTotal}", style: TextStyle(fontSize:22),),
            ],
          ),
          
        ],
      ),
    );
  }
}
