import 'package:delivery_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/screens/login_screen.dart';
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
      child: MaterialApp(
        title: 'Pida-lá',
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Color.fromARGB(255, 0, 255, 128),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          title: Text(model.userData["name"]?? "Entre para ver o nome"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: (){
                model.signOut();
              })
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              child: Text("Login Screen"),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      );
    });
  }
}
