import 'package:delivery_app/models/user_model.dart';
import 'package:delivery_app/screens/cart_screen.dart';
import 'package:delivery_app/tabs/order_tab.dart';
import 'package:delivery_app/tabs/supplier_tab.dart';
import 'package:delivery_app/tabs/home_tab.dart';
import 'package:delivery_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("Pagina Inicial"),
            centerTitle: true,
          ),
          body: HomeTab(_pageController),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Escolha um fornecedor"),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartScreen()));
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.shopping_cart_outlined,
            ),
            elevation: 4,
          ),
          body: SupplierTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrderTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Configurações"),
            centerTitle: true,
          ),
          body: Center(child: Text("TO-DO"),),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}
