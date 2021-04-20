import 'package:flutter/material.dart';

class SupplierScreen extends StatefulWidget {
  SupplierScreen({Key key}) : super(key: key);

  @override
  _SupplierScreenState createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Escolha seus produtos"),
         centerTitle: true,
       ),
       body: ListView(
         
       ),
    );
  }
}