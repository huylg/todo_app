import 'package:todo_app/network/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/root/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'flutter login app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(
          auth: Auth(),
        ));
  }
}
