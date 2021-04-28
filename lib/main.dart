import 'package:delivery_app/models/user_model.dart';
import 'package:delivery_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return MaterialApp(
          title: 'Pida-lá',
          theme: ThemeData(
            primarySwatch: Colors.green,
            primaryColor: Color.fromARGB(255, 0, 150, 128),
            backgroundColor: Colors.white
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      }),
    );
  }
}
